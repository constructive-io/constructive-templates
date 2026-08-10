-- Deploy: migrate/catalog_private.apis
-- made with <3 @ constructive.io

-- requires: migrate/webauthn_settings


SET session_replication_role TO replica;
-- using replica in case we are deploying triggers to metaschema_public

-- unaccent, postgis affected and require grants
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public to public;

DO $LQLMIGRATION$
  DECLARE
  BEGIN

    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), 'app_user');
    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), 'app_admin');

  END;
$LQLMIGRATION$;

INSERT INTO catalog_private.apis (
  id,
  owner_scope,
  owner_key,
  is_visible,
  database_id,
  name,
  dbname,
  role_name,
  anon_role,
  config
) VALUES
  ('019feb75-78e1-7197-a9bd-7f9075c774b2', 'database', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', true, '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'auth', NULL, 'authenticated', 'anonymous', NULL),
  ('019feb75-797a-7084-aa15-4fa0cfa05f39', 'database', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', true, '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'admin', NULL, 'authenticated', 'anonymous', NULL),
  ('019feb75-79c5-7aca-bac5-7e2c2ebb0400', 'database', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', true, '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'usage', NULL, 'authenticated', 'anonymous', NULL),
  ('019feb75-8966-7142-a594-0faf10ac7cd3', 'database', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', true, '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'config', NULL, 'authenticated', 'anonymous', NULL),
  ('019feb75-9402-7b4f-b836-399f826c4fb0', 'database', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', true, '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'api', NULL, 'authenticated', 'anonymous', NULL),
  ('019feb75-9402-7ce7-9a76-1ac03513c5f0', 'database', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', true, '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'compute', NULL, 'authenticated', 'anonymous', NULL),
  ('019feb75-9402-7d94-a3f7-065838d00cec', 'database', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', true, '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'objects', NULL, 'authenticated', 'anonymous', NULL),
  ('019feb75-9402-7e3e-a71f-bd6bb963e246', 'database', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', true, '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'agent', NULL, 'authenticated', 'anonymous', NULL),
  ('019feb75-b40f-7c2a-b4b0-fe1bf220facd', 'database', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', true, '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'migrate', NULL, 'authenticated', 'anonymous', NULL);


SET session_replication_role TO DEFAULT;


