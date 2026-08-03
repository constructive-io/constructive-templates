/**
 * reset-db.ts — Drop tenant schemas + metaschema records so create-db can
 * re-provision from scratch (e.g. after adding ORG_MODULES).
 *
 * Usage:  pnpm run reset-db
 *
 * What it does:
 *   1. Reads DATABASE_NAME and DATABASE_ID from .env
 *   2. Drops all {databaseName}_* schemas from the physical platform DB
 *   3. Cleans up routing_public, catalog_public, and metaschema_public records
 *   4. Removes DATABASE_ID and ACCESS_TOKEN from .env
 *
 * After reset, run: pnpm run create-db && pnpm run provision && pnpm codegen
 */

import { config } from './config.js';
import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';
import { Pool } from 'pg';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

async function main() {
  const databaseName = config.databaseName || 'myapp';
  const databaseId = config.databaseId;

  console.log('\n  Constructive App — Reset Database\n');
  console.log(`   Database:  ${databaseName}`);
  console.log(`   DB ID:     ${databaseId || '(not set)'}`);

  if (!process.env.PGHOST) {
    console.error('\n   !! PGHOST not set — run: eval "$(pgpm env)"\n');
    process.exit(1);
  }

  const pool = new Pool({ database: config.pgInternalDatabase });

  try {
    // --- Step 1: Drop all {databaseName}_* schemas ---
    console.log('\n   Dropping tenant schemas...');

    const schemasRes = await pool.query(
      `SELECT schema_name FROM information_schema.schemata
       WHERE schema_name LIKE $1
       ORDER BY schema_name`,
      [`${databaseName}_%`]
    );

    if (schemasRes.rows.length === 0) {
      console.log('   No tenant schemas found — nothing to drop.');
    } else {
      for (const { schema_name } of schemasRes.rows) {
        await pool.query(`DROP SCHEMA IF EXISTS ${schema_name} CASCADE`);
        console.log(`   ✓ Dropped ${schema_name}`);
      }
    }

    // --- Step 2: Clean up routing/catalog/metaschema records ---
    if (databaseId) {
      console.log('\n   Cleaning up platform records...');

      const cleanupTables: Array<{ table: string; column: string }> = [
        { table: 'routing_public.routes', column: 'database_id' },
        { table: 'routing_public.api_schemas', column: 'database_id' },
        { table: 'routing_public.domains', column: 'database_id' },
        { table: 'routing_public.apis', column: 'database_id' },
        { table: 'catalog_public.functions', column: 'database_id' },
      ];

      for (const { table, column } of cleanupTables) {
        try {
          const res = await pool.query(
            `DELETE FROM ${table} WHERE ${column} = $1`,
            [databaseId]
          );
          if (res.rowCount && res.rowCount > 0) {
            console.log(`   ✓ Cleaned ${table} (${res.rowCount} rows)`);
          }
        } catch {
          // Table might not exist or column might differ — skip silently
        }
      }

      // Delete the database record from metaschema (cascades to schema/table/field/etc.)
      try {
        const res = await pool.query(
          `DELETE FROM metaschema_public.database WHERE id = $1`,
          [databaseId]
        );
        if (res.rowCount && res.rowCount > 0) {
          console.log(`   ✓ Removed metaschema_public.database record`);
        }
      } catch {
        // Best-effort
      }

      // Clean up metaschema_modules_public entries
      try {
        await pool.query(
          `DELETE FROM metaschema_modules_public.hierarchy_module WHERE database_id = $1`,
          [databaseId]
        );
      } catch {
        // Table might not exist — skip
      }
    }

    // --- Step 3: Remove DATABASE_ID and ACCESS_TOKEN from .env ---
    console.log('\n   Cleaning .env...');

    const envPath = path.resolve(__dirname, '../../../.env');
    let envContent = '';
    try {
      envContent = fs.readFileSync(envPath, 'utf8');
    } catch {
      console.log('   .env not found — skipping');
    }

    if (envContent) {
      const lines = envContent.split('\n');
      const filtered = lines.filter(
        (line) =>
          !line.startsWith('DATABASE_ID=') &&
          !line.startsWith('ACCESS_TOKEN=')
      );
      fs.writeFileSync(envPath, filtered.join('\n').replace(/\n{3,}/g, '\n\n').trim() + '\n');
      console.log('   ✓ Removed DATABASE_ID and ACCESS_TOKEN from .env');
    }
  } finally {
    await pool.end();
  }

  console.log('\n  Reset complete. Run: pnpm run create-db && pnpm run provision && pnpm codegen\n');
}

main().catch((err) => {
  console.error('\nreset-db failed:', err.message ?? err);
  process.exit(1);
});
