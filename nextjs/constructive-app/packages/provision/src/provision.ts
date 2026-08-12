/**
 * provision.ts — Post-creation setup for the constructive-app
 *
 * Reads DATABASE_ID, ACCESS_TOKEN, DATABASE_NAME from .env (set by create-db)
 * and:
 *   1. Sets database-level schema naming strategy
 *   2. Attaches entity schemas to the app API
 *   3. Deduplicates PostGraphile resources via @name smart comments
 *   4. Sets app membership defaults (auto-approve new users)
 *   5. Provisions the migrate API for export (ddl_audit_public.sql_actions),
 *      so `pnpm export:graphql` can read the DB module's migration SQL
 *
 * The base auth:hardened app provisions no app-specific tables here — declare
 * your own via construct_blueprint() after this script (no blueprint ships
 * with the base scaffold).
 *
 * Usage:  pnpm run provision
 */

import { createFetch } from '@constructive-io/fetch';
import * as fs from 'fs';
import * as path from 'path';
import { Pool } from 'pg';

import { config } from './config.js';
import { withRetry, createMetaschemaClient } from './helpers.js';

// Schema-based tenancy: all SQL runs against the ONE physical platform DB
// (default 'constructive') — the tenant's schemas ({tenant}_*) live inside it.
// DATABASE_NAME is the logical tenant key used for schema-name filters and
// subdomain routing; it is NOT a connectable database. Do NOT use PGDATABASE
// either — pgpm env sets that to 'postgres' (the maintenance DB).
const PG_DATABASE = config.pgInternalDatabase;

async function main() {
  console.log('\n  Constructive App — Schema Provisioning\n');
  console.log(`   Database:  ${config.databaseName}`);
  console.log(`   DB ID:     ${config.databaseId}`);
  console.log(`   Endpoint:  ${config.apiEndpoint}`);

  if (!config.databaseId || !config.accessToken) {
    console.error('\n  Missing DATABASE_ID or ACCESS_TOKEN in .env');
    console.error('   Run: pnpm run create-db\n');
    process.exit(1);
  }

  // Set database-level session vars via ALTER DATABASE SET so every
  // GraphQL connection inherits them automatically.
  const pgAvailable = !!process.env.PGHOST;
  if (pgAvailable) {
    console.log('\n  Configuring database-level settings...');
    const pool = new Pool({ database: PG_DATABASE });
    const dbName = PG_DATABASE;

    // Schema naming strategy — clean names without hash suffixes, using underscores
    await pool.query(`ALTER DATABASE "${dbName}" SET constructive.simple_schema_names = 'true'`);
    await pool.query(`ALTER DATABASE "${dbName}" SET constructive.schema_use_underscores = 'true'`);

    await pool.end();
    console.log('   constructive.simple_schema_names = true');
    console.log('   constructive.schema_use_underscores = true');
  } else {
    console.log('\n  PGHOST not set — skipping database-level settings.');
    console.log('   Run: eval "$(pgpm env)" before provisioning.');
  }

  // -------------------------------------------------------------------------
  // Attach entity-related schemas to the 'app' API
  //
  // databaseProvisionModule creates the tenant schemas, but the app API
  // (api-{dbName}.localhost) only has {db}_app_public attached by default.
  // We attach the remaining schemas so the app endpoint exposes the full
  // provisioned surface (users, memberships, auth helpers, etc.).
  // -------------------------------------------------------------------------
  console.log(`\n${'='.repeat(60)}`);
  console.log('  Attaching schemas to app API');
  console.log('='.repeat(60));

  const metaschemaClient = createMetaschemaClient();

  // Find the 'api' API for this database via direct SQL (superuser) to bypass
  // the same RLS issue that breaks routing_public.apis GraphQL lookups here.
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  let appApi: any;
  const appApiLookupPool = new Pool({ database: PG_DATABASE });
  try {
    const appApiRes = await appApiLookupPool.query(
      `SELECT id, name, is_published AS "isPublic", role_name AS "roleName"
       FROM routing_public.apis
       WHERE database_id = $1 AND name = 'api'`,
      [config.databaseId]
    );
    appApi = appApiRes.rows[0] || null;
  } finally {
    await appApiLookupPool.end();
  }

  if (!appApi) {
    console.warn('   App API not found — skipping schema attachment');
  } else {
    const appApiId: string = appApi.id;

    // Get schema names already attached to the app API
    const attachedPool = new Pool({ database: PG_DATABASE });
    let existingSchemaNames: Set<string>;
    try {
      const attachedRes = await attachedPool.query(
        `SELECT s.schema_name
         FROM routing_public.api_schemas aps
         JOIN metaschema_public.schema s ON s.id = aps.schema_id
         WHERE aps.api_id = $1`,
        [appApiId]
      );
      existingSchemaNames = new Set(attachedRes.rows.map(r => r.schema_name));
    } finally {
      await attachedPool.end();
    }

    // Find all schemas for this database — we need the ones with entity tables
    const schemasPool = new Pool({ database: PG_DATABASE });
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    let allSchemas: any[] = [];
    try {
      const schemasRes = await schemasPool.query(
        `SELECT id, name, schema_name AS "schemaName"
         FROM metaschema_public.schema
         WHERE database_id = $1`,
        [config.databaseId]
      );
      allSchemas = schemasRes.rows;
    } finally {
      await schemasPool.end();
    }

    // Attach unattached schemas, excluding internal ones.
    // Exclude metaschema* (platform internals) and all *_private schemas
    // (SECURITY DEFINER helpers, trigger functions — not API-facing).
    // The previous approach only excluded auth_private; the general _private
    // suffix exclusion prevents PostGraphile duplicate-resource errors when
    // a function exists in both _private and _public schemas.
    const excludePrefixes = ['metaschema'];
    const schemasToAttach = allSchemas.filter((s: { schemaName: string }) =>
      !existingSchemaNames.has(s.schemaName) &&
      !excludePrefixes.some(prefix => s.schemaName.startsWith(prefix)) &&
      !s.schemaName.endsWith('_private')
    );

    if (schemasToAttach.length === 0) {
      console.log('   App API already has all needed schemas');
    } else {
      const attachPool = new Pool({ database: PG_DATABASE });
      try {
        for (const schema of schemasToAttach) {
          try {
            await attachPool.query(
              `INSERT INTO routing_public.api_schemas (database_id, api_id, schema_id)
               VALUES ($1, $2, $3)
               ON CONFLICT (api_id, schema_id) DO NOTHING`,
              [config.databaseId, appApiId, schema.id]
            );
            console.log(`   Attached ${schema.schemaName} to app API`);
          } catch (err: any) {
            // Already attached — that's fine
            if (err.message?.includes('already exists') || err.message?.includes('duplicate')) {
              console.log(`   ${schema.schemaName} already attached`);
            } else {
              console.warn(`   Failed to attach ${schema.schemaName}: ${err.message}`);
            }
          }
        }
      } finally {
        await attachPool.end();
      }
    }
  }

  // Deduplicate PostGraphile resources via smart comments.
  //
  // When multiple membership schemas are attached to the same API (e.g.
  // myapp_memberships_public, myapp_org_memberships_public), each contains
  // functions with the same name (e.g. get_organization_id). PostGraphile
  // normally adds a schema-qualifying prefix via _schemaPrefix(), but when
  // two schemas both map to the primary (unprefixed) position, the resource
  // names collide:
  //   "Attempted to add a second resource named 'get_organization_id'"
  //
  // The collision happens in PgProceduresPlugin BEFORE behavior tags are
  // checked, so '@behavior -resource' cannot prevent it. However, the
  // '@name' tag is read by functionResourceName() BEFORE addResource() is
  // called — so we can use '@name' to give each duplicate a unique resource
  // name derived from its schema, preventing the collision entirely.
  //
  // We keep the first (alphabetically) schema's function as the default
  // name (no @name override), and rename all subsequent duplicates with a
  // schema-derived @name tag (e.g. 'org_memberships_get_organization_id').
  // The function remains fully callable by RLS policies under its original
  // SQL name; only the GraphQL resource name changes.
  if (pgAvailable) {
    const dedupPool = new Pool({ database: PG_DATABASE });
    try {
      // Find functions that exist in multiple schemas attached to the app API.
      // We keep the first (alphabetically) schema's version with its default
      // name and give the rest unique @name tags to prevent collisions.
      const dupRes = await dedupPool.query(
        `WITH api_schemas AS (
           SELECT s.schema_name
           FROM routing_public.api_schemas aps
           JOIN metaschema_public.schema s ON s.id = aps.schema_id
           JOIN routing_public.apis a ON a.id = aps.api_id
           WHERE a.name = 'api' AND a.database_id = $1
         ),
         schema_functions AS (
           SELECT
             n.nspname AS schema_name,
             p.proname AS function_name,
             pg_get_function_identity_arguments(p.oid) AS args
           FROM pg_proc p
           JOIN pg_namespace n ON n.oid = p.pronamespace
           WHERE n.nspname = ANY(SELECT schema_name FROM api_schemas)
             AND p.prokind = 'f'  -- only functions, not aggregates/window
         ),
         duplicates AS (
           SELECT
             function_name,
             args,
             schema_name,
             row_number() OVER (
               PARTITION BY function_name, args
               ORDER BY schema_name  -- first alphabetically keeps default name
             ) AS rn
           FROM schema_functions
           WHERE (function_name, args) IN (
             SELECT function_name, args
             FROM schema_functions
             GROUP BY function_name, args
             HAVING count(*) > 1
           )
         )
         SELECT schema_name, function_name, args
         FROM duplicates
         WHERE rn > 1  -- skip the first occurrence (keeps default name)
         ORDER BY function_name, schema_name`,
        [config.databaseId]
      );

      if (dupRes.rows.length > 0) {
        console.log(`\n  Deduplicating PostGraphile resources (${dupRes.rows.length} duplicate(s)):`);
        for (const row of dupRes.rows) {
          const argsPart = row.args ? `(${row.args})` : '()';
          // Derive a unique @name from the schema prefix.
          // e.g. schema "myapp_org_memberships_public" → prefix "org_memberships"
          // Then the resource name becomes "org_memberships_get_organization_id"
          // which is distinct from the default "get_organization_id".
          const dbName = config.databaseName;
          const prefix = row.schema_name
            .replace(new RegExp(`^${dbName}_`), '')  // strip leading "myapp_"
            .replace(/_public$/, '')                  // strip trailing "_public"
            .replace(/_private$/, '');                // strip trailing "_private"
          const uniqueName = `${prefix}_${row.function_name}`;
          console.log(`    @name ${uniqueName} → ${row.schema_name}.${row.function_name}${argsPart}`);
          try {
            await dedupPool.query(
              `COMMENT ON FUNCTION "${row.schema_name}"."${row.function_name}"(${row.args || ''}) IS E'@name ${uniqueName}'`
            );
          } catch (commentErr: any) {
            console.warn(`    ⚠ Failed to add smart comment: ${commentErr.message}`);
          }
        }
      } else {
        console.log('\n  No duplicate PostGraphile resources found — smart comments not needed');
      }
    } catch (err: any) {
      console.warn(`  ⚠ Could not deduplicate PostGraphile resources: ${err.message}`);
    } finally {
      await dedupPool.end();
    }
  }


  // Local-dev patches are handled by the pgpm migration in
  // packages/dev-local/deploy/local-fixes.sql (validator fix, deterministic-id
  // trigger fix, app_memberships auto-approve). Run `pgpm deploy dev-local`
  // after provision to apply it.
  //
  // NOTE: diligence's historical schema-alias workaround (mirror views in
  // constructive_memberships_private pointing to {dbname}_memberships_private)
  // is intentionally NOT ported: it only matters for org-scope RLS joins and
  // storage_module uploads, neither of which the auth:hardened no-org surface
  // provisions. All routing_public writes in these scripts use direct SQL
  // (superuser), bypassing that RLS.
  if (pgAvailable) {
    console.log('\n  Local-dev patches: handled by pgpm migration (dev-local). Run: pgpm deploy dev-local');
  }

  // Set app membership defaults so new users are auto-approved.
  if (pgAvailable) {
    console.log('\n  Setting membership defaults...');
    const defaultsPool = new Pool({ database: PG_DATABASE });

    const schemaResult = await defaultsPool.query(
      `SELECT schema_name FROM information_schema.schemata
       WHERE (schema_name LIKE '%memberships-public' OR schema_name LIKE '%memberships_public')
             AND schema_name LIKE '%${config.databaseName}%'
       ORDER BY schema_name DESC LIMIT 1`
    );
    if (schemaResult.rows.length > 0) {
      const membershipsSchema = schemaResult.rows[0].schema_name;
      await defaultsPool.query(
        `UPDATE "${membershipsSchema}".app_membership_defaults
         SET is_approved = TRUE, is_verified = TRUE`
      );
      console.log(`   schema: ${membershipsSchema}`);
      console.log('   is_approved = TRUE, is_verified = TRUE');
    } else {
      console.log('   No memberships schema found - skipping defaults');
    }

    await defaultsPool.end();
  }

  // =====================================================================
  //  Provision the migrate API for export (sql_actions)
  // =====================================================================
  console.log(`\n${'='.repeat(60)}`);
  console.log('  Provisioning migrate API for export');
  console.log('='.repeat(60));

  // The migrate API exposes sql_actions via GraphQL so that
  // pnpm export:graphql can fetch the DB module (deploy/revert/verify SQL).
  //
  // sql_actions lives in db_migrate.sql_actions (shared, RLS-protected), but db_migrate
  // is intentionally excluded from GraphQL because it executes SQL (injection risk).
  // Instead, ddl_audit_public.sql_actions is a safe view (security_invoker = on) over
  // db_migrate.sql_actions — this is what MIGRATE_SCHEMAS = ['ddl_audit_public'] links.
  //
  // Steps:
  //   A.  Verify ddl_audit_public.sql_actions view exists
  //   B.  Find the ddl_audit_public schema entry in metaschema (via direct SQL)
  //   C.  Create/update the migrate API with isPublic: true
  //   D.  Link ddl_audit_public schema to the migrate API (via direct SQL)
  //   E.  Create migrate-{dbName} domain entry
  //   F.  Flush the GraphQL server cache

  // The metaschema tables (metaschema_public.schema, routing_public.domains,
  // etc.) live in the ONE physical platform DB alongside the tenant schemas
  // (schema-based tenancy). PG_DATABASE is that physical DB.
  const MIGRATE_DB = PG_DATABASE;

  // Step A: Verify the sql_actions view exists. The physical schema is
  // hash-prefixed (e.g. constructive_ddl_audit_public), so match by suffix.
  if (pgAvailable) {
    const discoverPool = new Pool({ database: MIGRATE_DB });
    try {
      const viewCheck = await discoverPool.query(
        `SELECT table_schema, table_name FROM information_schema.views
         WHERE table_name = 'sql_actions'
           AND table_schema LIKE '%ddl_audit_public'`
      );
      if (viewCheck.rows.length > 0) {
        console.log(`   Found ${viewCheck.rows[0].table_schema}.sql_actions (safe view over db_migrate)`);
      } else {
        console.warn('   ddl_audit_public.sql_actions not found — export will not include migration data');
      }
    } finally {
      await discoverPool.end();
    }
  }

  // Step B: Find the ddl_audit_public schema entry in metaschema by logical name.
  // provision_base_modules registers it with name='ddl_audit_public' and
  // schema_name=<hash-prefixed physical name>. We look up by logical name
  // to get the correct schema_id for linking to the migrate API.
  let ddlAuditSchemaId: string | undefined;
  if (pgAvailable) {
    const lookupPool = new Pool({ database: MIGRATE_DB });
    try {
      const result = await lookupPool.query(
        `SELECT s.id, s.schema_name, s.name, s.database_id
         FROM metaschema_public.schema s
         WHERE s.name = 'ddl_audit_public'
           AND EXISTS (
             SELECT 1 FROM information_schema.schemata
             WHERE schema_name = s.schema_name
           )
         ORDER BY s.schema_name DESC
         LIMIT 1`
      );
      if (result.rows.length > 0) {
        const row = result.rows[0];
        ddlAuditSchemaId = row.id;
        console.log(`   Found ddl_audit_public schema entry (id: ${row.id}, physical: ${row.schema_name})`);
      } else {
        console.warn('   No ddl_audit_public schema entry found in metaschema — sql_actions will not be available');
      }
    } catch (err: any) {
      console.warn(`   Could not look up ddl_audit_public schema: ${err.message}`);
    } finally {
      await lookupPool.end();
    }
  } else {
    console.error('   ERROR: No direct DB access — cannot look up ddl_audit_public schema entry.');
    console.error('   Full provisioning requires eval "$(pgpm env)" to set PGHOST/PGDATABASE.');
    console.error('   The migrate API for export will NOT work without this step.');
  }

  // Step C: Create or update the migrate API (isPublic: true)
  // isPublic: true is required so that domain-lookup routing (migrate.localhost)
  // works. The migrate API uses role_name='authenticated' so that RLS policies
  // (including export_category_filter AS RESTRICTIVE) are enforced during export.
  // The administrator role has BYPASSRLS which would defeat the filtering.
  //
  // Use direct SQL (superuser) for both lookup and update because the
  // routing_public.apis RLS policy hardcodes "constructive_memberships_private"
  // and cannot resolve the admin's org membership until the dev-local
  // schema alias workaround is in place. Even then, GraphQL JWT
  // context may not match the membership actor_id during this provisioning step.
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  let migrateApi: any;
  const migrateLookupPool = new Pool({ database: MIGRATE_DB });
  try {
    const migrateApiRes = await migrateLookupPool.query(
      `SELECT id, name, is_published AS "isPublic", role_name AS "roleName"
       FROM routing_public.apis
       WHERE database_id = $1 AND name = 'migrate'`,
      [config.databaseId]
    );
    migrateApi = migrateApiRes.rows[0] || null;
  } finally {
    await migrateLookupPool.end();
  }

  // The migrate API row is created during create-db.ts bootstrap (SQL INSERT
  // as superuser, bypassing RLS). Here we only UPDATE it via direct SQL.
  // INSERT on routing_public.apis is intentionally blocked by RLS for
  // authenticated users — the policy requires manage_services in the
  // platform-level org_memberships_sprt.
  if (!migrateApi) {
    console.warn('   migrate API not found — was create-db run? Skipping API creation.');
    console.warn('   INSERT is blocked by RLS; the row must exist from bootstrap.');
  } else {
    console.log(`   migrate API found (id: ${migrateApi.id}, isPublic: ${migrateApi.isPublic})`);
    // Update to isPublic: true + roleName: authenticated if needed.
    const needsIsPublicUpdate = !migrateApi.isPublic;
    const needsRoleNameUpdate = migrateApi.roleName !== 'authenticated';
    if (needsIsPublicUpdate || needsRoleNameUpdate) {
      console.log(
        `   Updating migrate API: ${[
          needsIsPublicUpdate && 'isPublic',
          needsRoleNameUpdate && 'roleName',
        ].filter(Boolean).join(', ')}...`
      );
      const migrateUpdatePool = new Pool({ database: MIGRATE_DB });
      try {
        await migrateUpdatePool.query(
          `UPDATE routing_public.apis
           SET is_published = true, role_name = 'authenticated'
           WHERE id = $1`,
          [migrateApi.id]
        );
        migrateApi.isPublic = true;
        migrateApi.roleName = 'authenticated';
        console.log('   Updated migrate API configuration');
        console.log('   roleName=authenticated allows RLS filtering on db_migrate.sql_actions');
      } catch (err: any) {
        console.warn(`   Could not update migrate API: ${err.message}`);
      } finally {
        await migrateUpdatePool.end();
      }
    }
  }

  // Step D: Link ddl_audit_public schema to migrate API
  if (ddlAuditSchemaId && migrateApi) {
    const linkPool = new Pool({ database: MIGRATE_DB });
    try {
      // Check if already linked
      const existing = await linkPool.query(
        `SELECT id FROM routing_public.api_schemas
         WHERE api_id = $1 AND schema_id = $2`,
        [migrateApi.id, ddlAuditSchemaId]
      );

      if (existing.rows.length > 0) {
        console.log('   ddl_audit_public already linked to migrate API');
      } else {
        console.log('   Linking ddl_audit_public schema to migrate API...');
        await linkPool.query(
          `INSERT INTO routing_public.api_schemas (database_id, api_id, schema_id)
           VALUES ($1, $2, $3)
           ON CONFLICT (api_id, schema_id) DO NOTHING`,
          [config.databaseId, migrateApi.id, ddlAuditSchemaId]
        );
        console.log('   Linked ddl_audit_public → migrate API');
      }
    } catch (err: any) {
      console.warn(`   Could not link ddl_audit_public schema: ${err.message}`);
    } finally {
      await linkPool.end();
    }
  } else if (!ddlAuditSchemaId) {
    console.error('   ERROR: Skipping ddl_audit_public link — schema entry not found.');
    console.error('   The migrate API will NOT expose sql_actions. Run provision with PG access.');
  } else if (!migrateApi) {
    console.error('   ERROR: Skipping ddl_audit_public link — migrate API not found.');
  }

  // Step E: Create migrate domain entry (migrate-{dbName})
  if (migrateApi) {
    const migrateHostname = `migrate-${config.databaseName}.localhost`;
    console.log(`   Creating ${migrateHostname} domain entry...`);
    let domainCreated = false;
    try {
      await withRetry(() =>
        metaschemaClient.domain.create({
          data: {
            databaseId: config.databaseId!,
            hostname: migrateHostname,
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          } as any,
          select: { id: true },
        }).unwrap()
      );
      console.log(`   Created domain: ${migrateHostname} → migrate API`);
      domainCreated = true;
    } catch (err: any) {
      if (err.message?.includes('already exists') || err.message?.includes('duplicate') || err.message?.includes('unique constraint')) {
        console.log(`   ${migrateHostname} domain already exists`);
        domainCreated = true;
      } else {
        console.warn(`   Could not create migrate domain via GraphQL: ${err.message}`);
      }
    }

    // Fallback: create domain via direct SQL (superuser bypasses RLS)
    if (!domainCreated && pgAvailable) {
      try {
        const domainPool = new Pool({ database: MIGRATE_DB });
        try {
          await domainPool.query(
            `INSERT INTO routing_public.domains (database_id, hostname)
             VALUES ($1, $2)
             ON CONFLICT DO NOTHING`,
            [config.databaseId, migrateHostname]
          );
          console.log(`   Created domain: ${migrateHostname} → migrate API (via SQL)`);
          domainCreated = true;
        } finally {
          await domainPool.end();
        }
      } catch (sqlErr: any) {
        console.warn(`   Could not create migrate domain via SQL: ${sqlErr.message}`);
      }
    }

    // Always create the route from domain to migrate API via SQL.
    // The GraphQL domain.create only creates the domain — routing is a separate
    // table (routing_public.routes) that must be linked regardless of which path
    // created the domain.
    if (domainCreated && pgAvailable) {
      try {
        const routePool = new Pool({ database: MIGRATE_DB });
        try {
          await routePool.query(
            `INSERT INTO routing_public.routes (database_id, domain_id, target_api_id)
             SELECT $1, d.id, $2
             FROM routing_public.domains d
             WHERE d.hostname = $3 AND d.database_id = $1
               AND NOT EXISTS (
                 SELECT 1 FROM routing_public.routes r
                 WHERE r.domain_id = d.id AND r.target_api_id = $2
               )
             ON CONFLICT DO NOTHING`,
            [config.databaseId, migrateApi.id, migrateHostname]
          );
          console.log(`   Linked route: ${migrateHostname} → migrate API`);
        } finally {
          await routePool.end();
        }
      } catch (routeErr: any) {
        console.warn(`   Could not create migrate route: ${routeErr.message}`);
      }
    }
  }

  // Step F: Flush GraphQL server cache so the new schema/API takes effect
  console.log('   Flushing GraphQL server cache for all subdomains...');
  const subdomainsToFlush: string[] = [];
  if (pgAvailable) {
    const flushPool = new Pool({ database: MIGRATE_DB });
    try {
      const domainsResult = await flushPool.query(
        `SELECT DISTINCT hostname FROM routing_public.domains
         WHERE database_id = $1`,
        [config.databaseId]
      );
      for (const row of domainsResult.rows) {
        subdomainsToFlush.push(row.hostname);
      }
    } catch (err: any) {
      console.warn(`   Could not list subdomains: ${err.message}`);
    } finally {
      await flushPool.end();
    }
  }
  // Always flush the api.localhost (default config) too
  if (!subdomainsToFlush.includes('localhost')) {
    subdomainsToFlush.push('localhost');
  }
  // Ensure the app API subdomain is always flushed (critical for seed)
  const appApiHost = `api-${config.databaseName}.localhost`;
  if (!subdomainsToFlush.includes(appApiHost)) {
    subdomainsToFlush.push(appApiHost);
  }
  const flushFn = createFetch();
  for (const host of subdomainsToFlush) {
    try {
      const flushUrl = `http://${host}:${process.env.NEXT_PUBLIC_API_PORT || '3000'}/flush`;
      const flushRes = await flushFn(flushUrl, { method: 'POST' });
      if (flushRes.ok) {
        console.log(`   Flushed: ${flushUrl}`);
      } else {
        console.warn(`   Flush returned ${flushRes.status} for ${flushUrl}`);
      }
    } catch (err: any) {
      console.warn(`   Could not flush ${host}: ${err.message}`);
    }
  }

  // Write SEED_SCHEMA to .env so seeding just works
  if (pgAvailable) {
    const detectPool = new Pool({ database: PG_DATABASE });
    const appSchemaResult = await detectPool.query(
      `SELECT schema_name FROM information_schema.schemata
       WHERE (schema_name LIKE '%app-public' OR schema_name LIKE '%app_public')
             AND schema_name LIKE '%${config.databaseName}%'
       ORDER BY schema_name DESC LIMIT 1`
    );
    await detectPool.end();

    if (appSchemaResult.rows.length > 0) {
      const seedSchema = appSchemaResult.rows[0].schema_name;
      console.log(`\n  Detected app schema: ${seedSchema}`);

      const envPath = path.resolve(process.cwd(), '../../.env');
      try {
        let envContent = fs.readFileSync(envPath, 'utf8');
        const regex = /^SEED_SCHEMA=.*/m;
        if (regex.test(envContent)) {
          envContent = envContent.replace(regex, `SEED_SCHEMA=${seedSchema}`);
        } else {
          envContent += `\nSEED_SCHEMA=${seedSchema}`;
        }
        fs.writeFileSync(envPath, envContent);
        console.log(`   SEED_SCHEMA written to .env`);
      } catch (e) {
        console.log(`   Could not update .env with SEED_SCHEMA (${e})`);
      }
    }
  }

  console.log('\n  Provisioning complete!\n');
}

main().catch((err) => {
  console.error('Provision failed:', err.message ?? err);
  process.exit(1);
});
