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
  ('019fc105-1b86-7b34-9d00-337192382d5f', 'admin-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b87-74f8-a768-72d917216b65', 'auth-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b87-772c-84d8-dcedc4a8f7b4', 'api-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b87-791f-8b51-e01181320f64', 'usage-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b87-7aff-add7-9b5e9c1afd07', 'compute-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b87-7cdb-86c5-e68c5e746feb', 'config-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b87-7f1f-8493-34c9d5633049', 'objects-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b88-70b9-8d61-8d298d3281c4', 'agent-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-a207-7b27-980e-f1b2fb72d6f7', 'migrate-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c');


SET session_replication_role TO DEFAULT;


