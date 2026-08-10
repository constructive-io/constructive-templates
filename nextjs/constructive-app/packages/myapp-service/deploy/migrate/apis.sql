-- Deploy: migrate/apis
-- made with <3 @ constructive.io

-- requires: migrate/api_schemas


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

INSERT INTO routing_public.apis (
  id,
  name,
  role_name,
  anon_role,
  is_published,
  config,
  database_id
) VALUES
  ('019feb75-78e1-7197-a9bd-7f9075c774b2', 'auth', 'authenticated', 'anonymous', true, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-797a-7084-aa15-4fa0cfa05f39', 'admin', 'authenticated', 'anonymous', true, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-79c5-7aca-bac5-7e2c2ebb0400', 'usage', 'authenticated', 'anonymous', true, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-8966-7142-a594-0faf10ac7cd3', 'config', 'authenticated', 'anonymous', true, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-9402-7b4f-b836-399f826c4fb0', 'api', 'authenticated', 'anonymous', true, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-9402-7ce7-9a76-1ac03513c5f0', 'compute', 'authenticated', 'anonymous', true, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-9402-7d94-a3f7-065838d00cec', 'objects', 'authenticated', 'anonymous', true, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-9402-7e3e-a71f-bd6bb963e246', 'agent', 'authenticated', 'anonymous', true, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b40f-7c2a-b4b0-fe1bf220facd', 'migrate', 'authenticated', 'anonymous', true, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6');


SET session_replication_role TO DEFAULT;


