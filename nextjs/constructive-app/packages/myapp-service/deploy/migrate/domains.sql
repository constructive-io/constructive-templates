-- Deploy: migrate/domains
-- made with <3 @ constructive.io

-- requires: migrate/apps


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

INSERT INTO services_public.domains (
  id,
  database_id,
  api_id,
  site_id,
  service_id,
  subdomain,
  domain,
  labels,
  annotations
) VALUES
  ('019fa2a1-4ffb-792c-a0ab-d702badbace0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5001-790c-8dfa-3347bd8f781b', NULL, NULL, 'admin-myapp', 'localhost', '{}', '{}'),
  ('019fa2a1-4ffd-778e-af5b-c7b4b114d49c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5002-72ae-930b-fa3c13f980d4', NULL, NULL, 'auth-myapp', 'localhost', '{}', '{}'),
  ('019fa2a1-4ffd-7f95-83b6-d22e048407ac', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5002-75ec-833a-651fda3d74d6', NULL, NULL, 'api-myapp', 'localhost', '{}', '{}'),
  ('019fa2a1-4ffe-7790-8737-1a0e3c02c487', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5002-78dc-aba5-6416d5eb3aa1', NULL, NULL, 'usage-myapp', 'localhost', '{}', '{}'),
  ('019fa2a1-4ffe-7f4a-a5d1-535740e74130', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5002-7ba8-9dc9-50d761475f33', NULL, NULL, 'compute-myapp', 'localhost', '{}', '{}'),
  ('019fa2a1-4fff-76c5-8daa-7731008e03bb', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-674d-7187-a86f-9ebcb7cdc736', NULL, NULL, 'config-myapp', 'localhost', '{}', '{}'),
  ('019fa2a1-5000-75a5-b96d-c4eccd69770f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5002-7e71-b97c-34cbe0c7cdc7', NULL, NULL, 'objects-myapp', 'localhost', '{}', '{}'),
  ('019fa2a1-5000-7bd7-bb40-6dce57c963c6', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5003-71ec-9509-7a1d4fbf22a4', NULL, NULL, 'agent-myapp', 'localhost', '{}', '{}'),
  ('019fa2a1-bd8e-7680-9f59-8ebe72b03428', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-762f-7b91-aeb4-b40200a7b932', NULL, NULL, 'migrate-myapp', 'localhost', '{}', '{}');


SET session_replication_role TO DEFAULT;


