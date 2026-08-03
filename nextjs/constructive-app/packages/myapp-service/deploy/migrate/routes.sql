-- Deploy: migrate/routes
-- made with <3 @ constructive.io

-- requires: migrate/rls_settings


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

INSERT INTO routing_public.routes (
  id,
  domain_id,
  target_api_id,
  target_site_id,
  target_function_id,
  target_service_id,
  target_bucket_id,
  path,
  method,
  priority,
  is_active,
  config,
  database_id
) VALUES
  ('019fbc96-e520-78c2-948c-8d7726a0a4ea', '019fbc96-e513-773a-8ddd-de1113e2cde6', '019fbc96-8659-7990-b05a-e190bd1190af', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e521-7bac-929f-5cc4d3d8cd7b', '019fbc96-e514-72a0-bb61-4a536b7225c3', '019fbc96-8532-70ad-82b8-cba1946925a2', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e522-70b0-812d-79428aba8d79', '019fbc96-e514-7522-9c71-e95ca5a7b504', '019fbc96-e51c-7f70-8057-8db4e69e84dd', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e522-7520-b2cf-12044e605720', '019fbc96-e514-775b-9a0c-49e151c573f1', '019fbc96-86ff-77df-af4f-455a6af96d90', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e522-79fb-b4a9-a30fe46e1a16', '019fbc96-e514-7983-9bd8-bb1f7d106111', '019fbc96-e51d-718e-b890-fa9c73d0aa3b', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e522-7e20-bc17-83c516f9630c', '019fbc96-e514-7d6e-81ea-3a7d5112713b', '019fbc96-e51d-7252-a9df-57833ad7c082', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e523-7591-92d7-08fefd4e36de', '019fbc96-e514-7ee2-879a-41fa73ca8be2', '019fbc96-e51d-730a-8e3d-923ff1b9266e', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e536-774e-94ea-3af8e147965b', '019fbc96-e514-7b65-ad0d-59e0d5dddeaa', '019fbc96-bf35-76f8-a63b-93787a2ed1eb', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-fb8d-73b8-8a12-84a9e8beebba', '019fbc96-fb7a-7ecc-a0f4-8f55384dfb4a', '019fbc96-e54f-71c3-b80e-b3c6c6ed8d82', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fbc96-84d8-7d13-8acc-4c55ad35634c');


SET session_replication_role TO DEFAULT;


