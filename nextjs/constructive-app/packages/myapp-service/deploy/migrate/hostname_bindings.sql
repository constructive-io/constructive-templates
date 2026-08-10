-- Deploy: migrate/hostname_bindings
-- made with <3 @ constructive.io

-- requires: migrate/routes


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

INSERT INTO routing_public.hostname_bindings (
  id,
  hostname,
  domain_id,
  is_wildcard,
  parent_hostname,
  managed,
  verification_status,
  tls_status,
  tls_secret_name
) VALUES
  ('2aa82f89-55d1-3ffc-bc5e-1d1845c0a107', 'objects-myapp.localhost', '019feb75-9400-7acd-a43b-b81000ff25f3', false, NULL, false, 'unverified', 'none', NULL),
  ('523518bc-32e0-926c-1ebb-391451009535', 'api-myapp.localhost', '019feb75-9400-71e8-868d-9f6b33211c1d', false, NULL, false, 'unverified', 'none', NULL),
  ('70d3d5ee-114a-90ed-5b49-5af31a07c266', 'auth-myapp.localhost', '019feb75-93ff-7f96-bf4d-b2c46b9acee8', false, NULL, false, 'unverified', 'none', NULL),
  ('8652f7df-849f-fb80-f782-9d6a5c7b2c13', 'compute-myapp.localhost', '019feb75-9400-7601-8113-e4d028e45bcb', false, NULL, false, 'unverified', 'none', NULL),
  ('8bc76385-5bbd-763d-08a9-ad1dad68a5d3', 'config-myapp.localhost', '019feb75-9400-7835-99f2-1cd51bf8d106', false, NULL, false, 'unverified', 'none', NULL),
  ('9d1d7dd0-8460-9cad-2661-816ae57ee0af', 'usage-myapp.localhost', '019feb75-9400-73fe-bbc9-e1d4da7b04b6', false, NULL, false, 'unverified', 'none', NULL),
  ('a131f778-44fd-3b64-362a-32eb8f82d8fb', 'migrate-myapp.localhost', '019feb75-be29-7996-a9fb-191bf253a037', false, NULL, false, 'unverified', 'none', NULL),
  ('d9caf7da-3cf0-2139-a9ab-b01feb17b567', 'admin-myapp.localhost', '019feb75-93ff-7511-abb5-c4110a0d5abb', false, NULL, false, 'unverified', 'none', NULL),
  ('f892ab93-e757-08d1-3421-d1f7bd4d8e08', 'agent-myapp.localhost', '019feb75-9400-7c4e-ba3c-b356c58848bb', false, NULL, false, 'unverified', 'none', NULL);


SET session_replication_role TO DEFAULT;


