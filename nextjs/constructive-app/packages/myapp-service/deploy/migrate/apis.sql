-- Deploy: migrate/apis
-- made with <3 @ constructive.io

-- requires: migrate/trigger_function


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

INSERT INTO services_public.apis (
  id,
  database_id,
  name,
  role_name,
  anon_role,
  is_public,
  labels,
  annotations
) VALUES
  ('019fa2a1-5001-790c-8dfa-3347bd8f781b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'admin', 'authenticated', 'anonymous', true, '{}', '{}'),
  ('019fa2a1-5002-72ae-930b-fa3c13f980d4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'auth', 'authenticated', 'anonymous', true, '{}', '{}'),
  ('019fa2a1-5002-75ec-833a-651fda3d74d6', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'api', 'authenticated', 'anonymous', true, '{}', '{}'),
  ('019fa2a1-5002-78dc-aba5-6416d5eb3aa1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'usage', 'authenticated', 'anonymous', true, '{}', '{}'),
  ('019fa2a1-5002-7ba8-9dc9-50d761475f33', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'compute', 'authenticated', 'anonymous', true, '{}', '{}'),
  ('019fa2a1-5002-7e71-b97c-34cbe0c7cdc7', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'objects', 'authenticated', 'anonymous', true, '{}', '{}'),
  ('019fa2a1-5003-71ec-9509-7a1d4fbf22a4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'agent', 'authenticated', 'anonymous', true, '{}', '{}'),
  ('019fa2a1-674d-7187-a86f-9ebcb7cdc736', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'config', 'authenticated', 'anonymous', true, '{}', '{}'),
  ('019fa2a1-762f-7b91-aeb4-b40200a7b932', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'migrate', 'authenticated', 'anonymous', true, '{}', '{}');


SET session_replication_role TO DEFAULT;


