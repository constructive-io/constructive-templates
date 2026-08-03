-- Deploy: migrate/domains
-- made with <3 @ constructive.io

-- requires: migrate/apis


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

INSERT INTO routing_public.domains (
  id,
  hostname,
  managed,
  is_wildcard,
  parent_hostname,
  verification_status,
  verified_at,
  tls_status,
  tls_ready_at,
  tls_secret_name,
  is_published,
  config,
  database_id
) VALUES
  ('019fbc96-e513-773a-8ddd-de1113e2cde6', 'admin-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e514-72a0-bb61-4a536b7225c3', 'auth-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e514-7522-9c71-e95ca5a7b504', 'api-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e514-775b-9a0c-49e151c573f1', 'usage-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e514-7983-9bd8-bb1f7d106111', 'compute-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e514-7b65-ad0d-59e0d5dddeaa', 'config-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e514-7d6e-81ea-3a7d5112713b', 'objects-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e514-7ee2-879a-41fa73ca8be2', 'agent-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-fb7a-7ecc-a0f4-8f55384dfb4a', 'migrate-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c');


SET session_replication_role TO DEFAULT;


