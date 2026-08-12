import { getConnections, PgTestClient } from 'pgsql-test';

let pg: PgTestClient;
let teardown: () => Promise<void>;

const TABLES: Record<string, string[]> = {
  'catalog_public': [
    'apis',
    'apps',
    'domains',
    'functions',
    'namespaces',
    'resource_definitions',
    'resource_installations',
    'resources',
    'sites'
  ]
};

// Schema + grants smoke test: proves the exported plane deploys and that its
// tables exist with schema USAGE granted (no RLS or trigger attachments ship
// in the base modules).
describe('catalog schema + grants', () => {
  beforeAll(async () => {
    ({ pg, teardown } = await getConnections());
  });

  afterAll(async () => {
    await teardown();
  });

  beforeEach(async () => {
    await pg.beforeEach();
  });

  afterEach(async () => {
    await pg.afterEach();
  });

  it('deploys every expected table', async () => {
    for (const [schema, tables] of Object.entries(TABLES)) {
      const rows = await pg.any(
        `SELECT tablename FROM pg_tables WHERE schemaname = $1 ORDER BY tablename`,
        [schema]
      );
      const found = rows.map((r: any) => r.tablename);
      for (const t of tables) {
        expect(found).toContain(t);
      }
    }
  });

  it('grants USAGE on public schemas to authenticated', async () => {
    for (const schema of Object.keys(TABLES).filter(s => s.endsWith('_public'))) {
      const [row] = await pg.any(
        `SELECT has_schema_privilege('authenticated', $1, 'USAGE') AS ok`,
        [schema]
      );
      expect(row.ok).toBe(true);
    }
  });

  it('ships no RLS policies', async () => {
    const rows = await pg.any(
      `SELECT polname FROM pg_policy p
       JOIN pg_class c ON c.oid = p.polrelid
       JOIN pg_namespace n ON n.oid = c.relnamespace
       WHERE n.nspname = ANY($1)`,
      [Object.keys(TABLES)]
    );
    expect(rows).toEqual([]);
  });
});
