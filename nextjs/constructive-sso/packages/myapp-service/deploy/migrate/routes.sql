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
  ('019fc105-1b90-7104-97b2-38d816dd9e94', '019fc105-1b86-7b34-9d00-337192382d5f', '019fc104-f428-7741-b519-19163a1626fa', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b91-71cf-93d6-400be66e8974', '019fc105-1b87-74f8-a768-72d917216b65', '019fc104-f2f3-71f4-834c-03b155978680', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b91-7652-844a-0b5bb1e0476f', '019fc105-1b87-772c-84d8-dcedc4a8f7b4', '019fc105-1b8d-7ee0-8a16-c2def252283c', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b91-79e5-b0c2-4209d12947cd', '019fc105-1b87-791f-8b51-e01181320f64', '019fc104-f4dd-73ef-9fa6-aa0cb488fb8e', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b91-7d3f-88a5-4e0847829f08', '019fc105-1b87-7aff-add7-9b5e9c1afd07', '019fc105-1b8e-706e-8914-c67e054db649', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b92-70ab-ae4f-9aee4ae9edf7', '019fc105-1b87-7f1f-8493-34c9d5633049', '019fc105-1b8e-7117-9278-01c0154a4f1f', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b92-75cb-8289-d310a137387c', '019fc105-1b88-70b9-8d61-8d298d3281c4', '019fc105-1b8e-71c0-81fa-a18d33dc9afa', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b9f-7ce7-a4f2-be02a6e71764', '019fc105-1b87-7cdb-86c5-e68c5e746feb', '019fc105-0a8b-7828-9d1b-94e6b0601720', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-a217-720e-8c37-8dabc4275ffd', '019fc105-a207-7b27-980e-f1b2fb72d6f7', '019fc105-1bb2-741c-b9a3-d74fc015b293', NULL, NULL, NULL, NULL, '/', NULL, 0, true, NULL, '019fc104-f28d-7b9c-8d9d-8f338def573c');


SET session_replication_role TO DEFAULT;


