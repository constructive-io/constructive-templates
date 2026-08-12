import { getConnections, PgTestClient } from 'pgsql-test';

let pg: PgTestClient;
let teardown: () => Promise<void>;

const TABLES: Record<string, string[]> = {
  'platform_routing_private': [],
  'platform_routing_public': [
    'platform_hostname_bindings',
    'platform_route_bindings',
    'platform_routes'
  ],
  'routing_private': [],
  'routing_public': [
    'platform_api_schemas',
    'platform_api_settings',
    'platform_apis',
    'platform_cors_settings',
    'platform_domain_events',
    'platform_domain_verifications',
    'platform_domains',
    'platform_email_identities',
    'platform_email_provider_accounts',
    'platform_email_site_identities',
    'platform_managed_domains',
    'platform_pages',
    'platform_site_app_links',
    'platform_site_deep_links',
    'platform_site_error_pages',
    'platform_site_metadata',
    'platform_site_modules',
    'platform_site_themes',
    'platform_site_web_configs',
    'platform_sites'
  ]
};

// Schema + grants smoke test: proves the exported plane deploys and that its
// tables exist with schema USAGE granted (no RLS or trigger attachments ship
// in the base modules).
describe('routing-platform schema + grants', () => {
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
