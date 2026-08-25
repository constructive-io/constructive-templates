/**
 * bind-routes — tenant-side function registration and route binding.
 *
 * Replaces the removed `fun register --route-database-id` flow: upstream's
 * model has the TENANT install the shared function manifests onto its own
 * plane (definition rows stamped with the tenant's database_id — exactly what
 * the route-target ownership guard's second arm requires), while the image
 * and its deployments stay platform-registered via plain `fun register`.
 *
 * In order:
 *   1. authenticate as the platform-bootstrap principal,
 *   2. discover the tenant's provisioned function-module scope (never
 *      guessed — a scope with no module would register rows nothing
 *      resolves),
 *   3. register every sso + mantra manifest method under the TENANT's
 *      database claim (`metaschema_private.register_function`, the same verb
 *      `fun register` generates — run here at the tenant context the way the
 *      platform testkit's registerFeature does),
 *   4. bind the tenant's routes on its `localhost` domain:
 *      the sso sync-lane paths from the sso manifest, and the mantra page
 *      set resolved from the platform's own `route_bindings` preset —
 *      `/auth/callback` therefore lands on `mantra:oauth_callback`, not
 *      `sso:callback` (the mantra page set owns it; the sso manifest's
 *      page-lane callback is deliberately not routed),
 *   5. verify every route through the shared plane's resolver, the way the
 *      gateway asks.
 *
 * Fail-loud throughout: a missing plane, an unresolvable task, or a route
 * that does not resolve is a provisioning fault to surface, never to skip.
 */

import { readFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

import * as dotenv from 'dotenv';
import { Client } from 'pg';

const MODULE_DIR = dirname(fileURLToPath(import.meta.url));
const ROOT_ENV_PATH = resolve(MODULE_DIR, '../../../.env');
dotenv.config({ path: ROOT_ENV_PATH });

const env = process.env;
const BOOTSTRAP_PRINCIPAL = 'platform-bootstrap';
const DOMAIN = env.SSO_ROUTE_HOST ?? 'localhost';
const MANTRA_PRESET_SLUG = env.MANTRA_PRESET_SLUG ?? 'mantra';

const PGHOST = env.PGHOST ?? 'localhost';
const PGPORT = Number(env.PGPORT ?? 15432);
const PGDATABASE = env.PGDATABASE ?? 'constructive-functions-db1';
const PGUSER = env.PGUSER ?? 'postgres';
const PGPASSWORD = env.PGPASSWORD ?? 'password';

const DATABASE_ID = env.DATABASE_ID ?? '';
// The constructive-db checkout, resolved the way local-bringup.sh does
// (CONSTRUCTIVE_DB_DIR relative to the boilerplate ROOT; src -> provision ->
// packages -> root is three levels up from this module).
const DB_REPO = resolve(MODULE_DIR, '../../../', env.CONSTRUCTIVE_DB_DIR ?? '../../../constructive-db');

const required = (name: string, why: string): string => {
  const value = env[name];
  if (!value) throw new Error(`missing ${name} in the environment (${why})`);
  return value;
};

/** One method of a feature manifest — the fields registration needs. */
interface ManifestMethod {
  taskIdentifier?: string;
  accessChannels?: string[];
  route?: string;
  description?: string;
}

interface FeatureManifest {
  name: string;
  image?: string;
  runtime?: string;
  description?: string;
  requires?: {
    secrets?: unknown[];
    configs?: unknown[];
    buckets?: string[];
    models?: string[];
    modules?: string[];
  };
  methods: ManifestMethod[];
}

/** The (category, name) pair a task identifier splits into. */
const splitTask = (task: string): { category: string; name: string } => {
  const index = task.indexOf(':');
  if (index < 0) throw new Error(`task identifier '${task}' carries no category`);
  return { category: task.slice(0, index), name: task.slice(index + 1) };
};

const readManifest = (feature: string): FeatureManifest => {
  const path = resolve(DB_REPO, 'functions', feature, 'handlers', 'handler.json');
  const manifest = JSON.parse(readFileSync(path, 'utf8')) as FeatureManifest;
  // Upstream refuses a manifest that declares "scope": which plane owns the
  // row is a property of the registering run (here: the tenant's).
  if ('scope' in (manifest as unknown as Record<string, unknown>)) {
    throw new Error(`${feature}/handler.json declares "scope" — remove it; the scope comes from the registering run`);
  }
  return manifest;
};

/** The sso sync-lane paths: methods a browser addresses through the gateway. */
const ssoSyncRoutes = (manifest: FeatureManifest): Array<{ path: string; task: string }> => {
  const routes: Array<{ path: string; task: string }> = [];
  for (const method of manifest.methods) {
    const task = method.taskIdentifier;
    if (!task) continue;
    const channels = method.accessChannels ?? [];
    // Only the sync lane is invoked by the app's BFF over HTTP; the page lane
    // (sso:callback at /auth/callback) is the mantra page set's to serve.
    if (channels.includes('sync') && method.route) {
      routes.push({ path: method.route, task });
    }
  }
  return routes;
};

async function main(): Promise<void> {
  if (!DATABASE_ID) throw new Error('missing DATABASE_ID in the environment (run create-db first)');
  const tenantDatabaseId = DATABASE_ID;

  const client = new Client({ host: PGHOST, port: PGPORT, database: PGDATABASE, user: PGUSER, password: PGPASSWORD });
  try {
    await client.connect();
  } catch (err: unknown) {
    const detail = err instanceof Error ? (err.stack ?? err.message) : String(err);
    throw new Error(
      `cannot connect to the platform database (${PGHOST}:${PGPORT}/${PGDATABASE}) — ` +
        `is 'fun up --k8s --alt-ports' running and finished?\n${detail}`
    );
  }

  // The same service identity the fun CLI acts as — never an invented JWT.
  const principal = await client.query(
    `SELECT id, user_id FROM constructive_auth_public.principals WHERE name = $1`,
    [BOOTSTRAP_PRINCIPAL]
  );
  if (principal.rowCount === 0) {
    throw new Error(`principal '${BOOTSTRAP_PRINCIPAL}' not found — fun up must have bootstrapped it`);
  }
  const { id: principalId, user_id: userId } = principal.rows[0] as { id: string; user_id: string };
  const actorClaims = JSON.stringify({
    'jwt.claims.user_id': userId,
    'jwt.claims.principal_id': principalId,
  });
  // Claims carrying the TENANT's database_id: the register_function verb keys
  // its rows to the executing database, so this is what stamps the tenant's
  // plane. The values are set per-transaction (true), never session-wide.
  const tenantClaims = JSON.stringify({
    'jwt.claims.database_id': tenantDatabaseId,
    'jwt.claims.user_id': userId,
    'jwt.claims.principal_id': principalId,
  });

  const setClaims = (claims: string): string => 'SELECT set_config(c.key, c.value, true) FROM jsonb_each_text($1::jsonb) AS c';

  // ---- 1. Ensure the tenant's function plane: a recorded fact, never a guess.
  // Presets like `b2b:storage` install no function_module (only `full` does,
  // and its cold-provisioning path is broken upstream — the job can't reach
  // the platform DB from inside its pod), so provision the plane right here:
  // one module row at the tenant's catalog scope, under the tenant's claims —
  // the BEFORE INSERT trigger builds the schemas/tables and binds the
  // tenant's catalog plane. Idempotent: a plane that already exists is left
  // exactly as the previous run (or a newer preset) created it.
  let scopes = (await client.query(
    `SELECT scope FROM metaschema_modules_public.function_module WHERE database_id = $1`,
    [tenantDatabaseId]
  )).rows.map((r) => (r as { scope: string }).scope);

  if (scopes.length === 0) {
    // The plane's definitions register into the tenant's catalog — provision
    // it at the scope that catalog lives at (every preset installs one).
    const catalog = await client.query(
      `SELECT scope FROM metaschema_modules_public.catalog_module WHERE database_id = $1 ORDER BY scope LIMIT 1`,
      [tenantDatabaseId]
    );
    if (catalog.rowCount === 0) {
      throw new Error(
        `no catalog_module provisioned for tenant ${tenantDatabaseId} — the tenant preset must install one ` +
          `before a function plane can be bound to it`
      );
    }
    const catalogScope = (catalog.rows[0] as { scope: string }).scope;
    await client.query('BEGIN');
    await client.query(setClaims(tenantClaims), [tenantClaims]);
    await client.query(
      `INSERT INTO metaschema_modules_public.function_module (database_id, scope) VALUES ($1, $2)`,
      [tenantDatabaseId, catalogScope]
    );
    await client.query('COMMIT');
    console.log(`function plane: provisioned at scope '${catalogScope}' for tenant ${tenantDatabaseId}`);
    scopes = [catalogScope];
  }
  const preferred = ['database', 'app', 'platform'];
  const scope = preferred.find((s) => scopes.includes(s)) ?? scopes.sort()[0];
  console.log(`function plane: scope '${scope}' (provisioned: ${scopes.join(', ')})`);

  // ---- 2. Register the shared manifests onto the tenant's plane.
  const sso = readManifest('sso');
  const mantra = readManifest('mantra');
  const registerOne = async (manifest: FeatureManifest, method: ManifestMethod): Promise<void> => {
    const task = method.taskIdentifier;
    if (!task) return;
    const { category, name } = splitTask(task);
    // Idempotent — but check the TENANT's own stamp, never the frame walk:
    // `function_resolution.resolve` falls through to the platform's definition
    // when the tenant plane is empty, and treating that as "already
    // registered" would skip every registration and bind routes at
    // platform-stamped targets the route guard refuses. A previous run
    // leaves an ownerless row stamped with the tenant's database_id.
    const existing = await client.query(
      `SELECT 1 FROM catalog_private.functions
        WHERE task_identifier = $1 AND database_id = $2 AND owner_key IS NULL`,
      [task, tenantDatabaseId]
    );
    if (existing.rows.length > 0) return;

    await client.query('BEGIN');
    await client.query(setClaims(tenantClaims), [tenantClaims]);
    await client.query(
      `SELECT metaschema_private.register_function(
         module_scope := $1, category := $2, name := $3, is_published := true,
         description := $4, runtime := $5, image := $6,
         access_channels := $7::text[],
         required_secrets := $8::jsonb, required_configs := $9::jsonb,
         required_buckets := $10::text[], required_models := $11::text[],
         required_modules := $12::text[]
       )`,
      [
        scope,
        category,
        name,
        method.description ?? manifest.description ?? `${category}:${name}`,
        manifest.runtime ?? 'http',
        manifest.image ?? manifest.name,
        method.accessChannels ?? [],
        JSON.stringify(manifest.requires?.secrets ?? []),
        JSON.stringify(manifest.requires?.configs ?? []),
        manifest.requires?.buckets ?? [],
        manifest.requires?.models ?? [],
        manifest.requires?.modules ?? [],
      ]
    );
    await client.query('COMMIT');
    console.log(`  registered ${task} on the tenant plane`);
  };
  for (const method of sso.methods) await registerOne(sso, method);
  for (const method of mantra.methods) await registerOne(mantra, method);

  // ---- 3. The shared routing plane: the platform's database-scope
  //      registration, read as facts (table, key column, resolver) the way
  //      the gateway's RouteRegistry reads them.
  const plane = await client.query(
    `SELECT s.schema_name AS routes_schema, t.name AS routes_table,
            rm.entity_field, rm.resolver_function_name
       FROM metaschema_modules_public.route_module rm
       JOIN metaschema_public."table" t ON t.id = rm.routes_table_id
       JOIN metaschema_public.schema s ON s.id = t.schema_id
      WHERE rm.scope = 'database'
        AND rm.database_id = app_scope.platform_database_id()`
  );
  if (plane.rowCount === 0) {
    throw new Error('no database-scope route_module registration at the platform — is the platform fully provisioned?');
  }
  const { routes_schema: routesSchema, routes_table: routesTable, resolver_function_name: resolverFn } =
    plane.rows[0] as { routes_schema: string; routes_table: string; resolver_function_name: string };
  const entityField = (plane.rows[0] as { entity_field: string | null }).entity_field;
  if (!entityField) {
    throw new Error("the shared routing plane records no entity field — cannot key the tenant's route rows");
  }
  if (!resolverFn) {
    throw new Error('the shared routing plane records no resolver function — cannot verify the bound routes');
  }

  // ---- 4. The tenant's domain on that plane.
  // The domains table is its own registration; resolve it the same way.
  const dom = await client.query(
      `SELECT s.schema_name AS domains_schema, t.name AS domains_table
         FROM metaschema_modules_public.domain_module dm
         JOIN metaschema_public."table" t ON t.id = dm.domains_table_id
         JOIN metaschema_public.schema s ON s.id = t.schema_id
        WHERE dm.database_id = app_scope.platform_database_id()`
    );
  if (dom.rowCount === 0) {
    throw new Error('no domain_module registration at the platform — is the platform fully provisioned?');
  }
  const { domains_schema: domainsSchema, domains_table: domainsTable } = dom.rows[0] as {
    domains_schema: string;
    domains_table: string;
  };
  const domain = await client.query(
    `SELECT id FROM "${domainsSchema}"."${domainsTable}" WHERE hostname = $1 AND database_id = $2`,
    [DOMAIN, tenantDatabaseId]
  );
  if (domain.rowCount === 0) {
    throw new Error(`domain '${DOMAIN}' owned by tenant ${tenantDatabaseId} not found — run create-db first`);
  }
  const domainId = (domain.rows[0] as { id: string }).id;

  // The resolver only serves hostnames whose binding is 'verified' — the
  // platform verifies its own managed hostnames at provision time, and a
  // tenant's claimed hostname arrives 'unverified' (DNS verification is the
  // production path). 'localhost' is a loopback host that can never fail a
  // DNS check, so a local bring-up verifies its claim directly. Idempotent.
  await client.query(
    `UPDATE routing_public.hostname_bindings SET verification_status = 'verified' WHERE domain_id = $1`,
    [domainId]
  );

  // ---- 5. The route set to bind: the sso sync-lane paths plus the mantra
  //      preset, resolved from the platform's own catalog (never hardcoded —
  //      retuning the page set is an UPDATE, not a boilerplate change).
  const bindings: Array<{ path: string; task: string }> = ssoSyncRoutes(sso);
  const preset = await client.query(
    `SELECT metaschema_generators.content_preset_definition('route_bindings', $1) AS bindings`,
    [MANTRA_PRESET_SLUG]
  );
  if (preset.rowCount === 0) {
    throw new Error(`route_bindings preset '${MANTRA_PRESET_SLUG}' not found in the platform catalog`);
  }
  const mantraBindings = preset.rows[0] as { bindings: Array<{ path: string; task_identifier: string }> };
  if (!Array.isArray(mantraBindings.bindings) || mantraBindings.bindings.length === 0) {
    throw new Error(`route_bindings preset '${MANTRA_PRESET_SLUG}' carries no bindings`);
  }
  for (const entry of mantraBindings.bindings) {
    bindings.push({ path: entry.path, task: entry.task_identifier });
  }

  // The callback collision, resolved by construction: the sso manifest's
  // page-lane route never enters `bindings` (only its sync lane does), so
  // `/auth/callback` is bound exactly once — by mantra:oauth_callback.
  const seen = new Set<string>();
  for (const { path } of bindings) {
    if (seen.has(path)) throw new Error(`path '${path}' declared twice in the route set — refusing to guess the winner`);
    seen.add(path);
  }

  // ---- 6. Bind: resolve each task at the tenant's frame and write the row.
  const insertRoute = async (path: string, task: string): Promise<void> => {
    const resolved = await client.query(
      `SELECT function_definition_id FROM function_resolution.resolve($1, $2, NULL, $3)`,
      [tenantDatabaseId, scope, task]
    );
    if (resolved.rows.length === 0) {
      throw new Error(`task '${task}' does not resolve at (tenant ${tenantDatabaseId}, scope '${scope}') — registration must have failed`);
    }
    const definitionId = (resolved.rows[0] as { function_definition_id: string }).function_definition_id;

    await client.query('BEGIN');
    await client.query(setClaims(actorClaims), [actorClaims]);
    await client.query(
      `INSERT INTO "${routesSchema}"."${routesTable}" (${entityField}, domain_id, path, target_function_id)
       SELECT $1, $2, $3, $4
        WHERE NOT EXISTS (
          SELECT 1 FROM "${routesSchema}"."${routesTable}" AS x
           WHERE x.domain_id = $2 AND x.path = $3 AND x."${entityField}" = $1
        )`,
      [tenantDatabaseId, domainId, path, definitionId]
    );
    await client.query('COMMIT');

    // A row that does not resolve is a fault, not a skip: the gateway would
    // serve the wrong handler or none, exactly the failure this step exists
    // to prevent.
    const answer = await client.query(
      `SELECT target_source_id FROM "${routesSchema}"."${resolverFn}"($1, $2, 'GET')`,
      [DOMAIN, path]
    );
    const target = (answer.rows[0] as { target_source_id: string | null } | undefined)?.target_source_id ?? null;
    if (target !== definitionId) {
      throw new Error(
        `${DOMAIN}${path} resolves to ${target ?? 'no route'}, not the '${task}' definition just bound (${definitionId}) — ` +
          'the routing plane and the resolver disagree'
      );
    }
    console.log(`  ${DOMAIN}${path} -> ${task}`);
  };

  console.log(`binding ${bindings.length} route(s) on '${DOMAIN}':`);
  for (const { path, task } of bindings) await insertRoute(path, task);
  console.log(`tenant ${tenantDatabaseId}: definitions registered, ${bindings.length} route(s) resolving on ${DOMAIN}`);

  await client.end();
}

main().catch((err: unknown) => {
  console.error(err instanceof Error ? (err.stack ?? err.message) || String(err) : String(err));
  process.exit(1);
});
