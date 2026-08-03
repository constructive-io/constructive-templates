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
  ('019fbc96-8532-70ad-82b8-cba1946925a2', 'auth', 'authenticated', 'anonymous', true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-8659-7990-b05a-e190bd1190af', 'admin', 'authenticated', 'anonymous', true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-86ff-77df-af4f-455a6af96d90', 'usage', 'authenticated', 'anonymous', true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-bf35-76f8-a63b-93787a2ed1eb', 'config', 'authenticated', 'anonymous', true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e51c-7f70-8057-8db4e69e84dd', 'api', 'authenticated', 'anonymous', true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e51d-718e-b890-fa9c73d0aa3b', 'compute', 'authenticated', 'anonymous', true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e51d-7252-a9df-57833ad7c082', 'objects', 'authenticated', 'anonymous', true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e51d-730a-8e3d-923ff1b9266e', 'agent', 'authenticated', 'anonymous', true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e54f-71c3-b80e-b3c6c6ed8d82', 'migrate', 'authenticated', 'anonymous', true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c');


SET session_replication_role TO DEFAULT;


