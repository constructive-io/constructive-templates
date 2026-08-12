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
  ('019feb75-93ff-7511-abb5-c4110a0d5abb', 'admin-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-93ff-7f96-bf4d-b2c46b9acee8', 'auth-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-9400-71e8-868d-9f6b33211c1d', 'api-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-9400-73fe-bbc9-e1d4da7b04b6', 'usage-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-9400-7601-8113-e4d028e45bcb', 'compute-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-9400-7835-99f2-1cd51bf8d106', 'config-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-9400-7acd-a43b-b81000ff25f3', 'objects-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-9400-7c4e-ba3c-b356c58848bb', 'agent-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-be29-7996-a9fb-191bf253a037', 'migrate-myapp.localhost', false, false, NULL, 'unverified', NULL, 'none', NULL, NULL, false, NULL, '019feb75-7843-7bd5-a19f-88c4cbec0ee6');


SET session_replication_role TO DEFAULT;


