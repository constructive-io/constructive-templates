import { getConnections, PgTestClient } from 'pgsql-test';

let pg: PgTestClient;
let teardown: () => Promise<void>;

const TABLES: Record<string, string[]> = {
  'routing_public': [
    'api_schemas',
    'api_settings',
    'apis',
    'cors_settings',
    'database_settings',
    'domain_events',
    'domain_verifications',
    'domains',
    'hostname_bindings',
    'http_routes',
    'managed_domains',
    'pubkey_settings',
    'rls_settings',
    'route_bindings',
    'routes',
    'site_metadata',
    'site_modules',
    'site_themes',
    'sites',
    'webauthn_settings'
  ]
};

// Schema + grants smoke test: proves the exported plane deploys and that its
// tables exist with schema USAGE granted. The only procedures shipped are the
// routing read-path resolvers; the only triggers are the catalog-sync
// propagation attachments (their trigger fns live in catalog_public).
describe('routing schema + grants', () => {
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

  it('ships only the read-path resolvers, no internal procedures', async () => {
    const rows = await pg.any(
      `SELECT p.proname FROM pg_proc p
       JOIN pg_namespace n ON n.oid = p.pronamespace
       WHERE n.nspname = 'routing_public'
       ORDER BY 1`
    );
    expect(rows.map((r: any) => r.proname)).toEqual(['api_schema_names', 'resolve_route']);
  });

  it('resolve_route is callable', async () => {
    const rows = await pg.any(
      `SELECT * FROM routing_public.resolve_route('nonexistent.example.com', '/', 'GET')`
    );
    expect(rows).toHaveLength(1);
    expect(rows[0].route_binding_id).toBeNull();
  });

  it('attaches catalog-sync triggers on the scoped source tables', async () => {
    const rows = await pg.any(
      `SELECT c.relname, t.tgname FROM pg_trigger t
       JOIN pg_class c ON c.oid = t.tgrelid
       JOIN pg_namespace n ON n.oid = c.relnamespace
       WHERE n.nspname = 'routing_public' AND NOT t.tgisinternal
         AND t.tgname LIKE '%catalog%'
       ORDER BY 1, 2`
    );
    const pairs = rows.map((r: any) => `${r.relname}.${r.tgname}`);
    expect(pairs).toContain('apis.catalog_sync');
    expect(pairs).toContain('sites.catalog_sync');
    expect(pairs).toContain('domains.catalog_sync');
  });
});
