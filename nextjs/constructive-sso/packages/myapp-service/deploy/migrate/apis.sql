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
  ('019fc104-f2f3-71f4-834c-03b155978680', 'auth', 'authenticated', 'anonymous', true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc104-f428-7741-b519-19163a1626fa', 'admin', 'authenticated', 'anonymous', true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc104-f4dd-73ef-9fa6-aa0cb488fb8e', 'usage', 'authenticated', 'anonymous', true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-0a8b-7828-9d1b-94e6b0601720', 'config', 'authenticated', 'anonymous', true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b8d-7ee0-8a16-c2def252283c', 'api', 'authenticated', 'anonymous', true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b8e-706e-8914-c67e054db649', 'compute', 'authenticated', 'anonymous', true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b8e-7117-9278-01c0154a4f1f', 'objects', 'authenticated', 'anonymous', true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b8e-71c0-81fa-a18d33dc9afa', 'agent', 'authenticated', 'anonymous', true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1bb2-741c-b9a3-d74fc015b293', 'migrate', 'authenticated', 'anonymous', true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c');


SET session_replication_role TO DEFAULT;


