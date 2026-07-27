-- Deploy: migrate/schema
-- made with <3 @ constructive.io

-- requires: migrate/database


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

INSERT INTO metaschema_public.schema (
  id,
  database_id,
  name,
  schema_name,
  label,
  description,
  smart_tags,
  category,
  tags,
  is_public,
  api_exposure
) VALUES
  ('019fa2a1-4fb9-782c-a61c-7922a0a61d27', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'app_public', 'myapp_app_public', 'app_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fa2a1-4fba-772a-bee5-b9d7472c1874', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'app_private', 'myapp_app_private', 'app_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fa2a1-500d-750e-b14a-d15cb605624f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'users_public', 'myapp_users_public', 'users_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fa2a1-50aa-7d8f-841d-7965af0951a1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'memberships_public', 'myapp_memberships_public', 'memberships_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fa2a1-5105-75da-89c6-6d24ad9cdf16', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'permissions_public', 'myapp_permissions_public', 'permissions_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fa2a1-5119-7816-ab77-973ecdcdafa4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'permissions_private', 'myapp_permissions_private', 'permissions_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fa2a1-51a3-7e09-92ab-08da59fa62d6', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'limits_public', 'myapp_limits_public', 'limits_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fa2a1-51bb-7c48-a313-feb84675ce8d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'limits_private', 'myapp_limits_private', 'limits_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fa2a1-5560-76ce-bbf2-797a38176260', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'memberships_private', 'myapp_memberships_private', 'memberships_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fa2a1-5af9-72d1-8fba-f96774dd90ce', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'store_private', 'myapp_store_private', 'store_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fa2a1-5b92-7e43-b110-f1d39bc5ee19', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'auth_private', 'myapp_auth_private', 'auth_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fa2a1-6722-709f-922e-d839fd79c906', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'store_public', 'myapp_store_public', 'store_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fa2a1-68d3-7385-938c-1973d9bed8f2', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'auth_public', 'myapp_auth_public', 'auth_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fa2a1-6946-7910-96e2-15c6e11fd525', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'user_identifiers_public', 'myapp_user_identifiers_public', 'user_identifiers_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fa2a1-6977-72e2-86f0-50e4ac24796a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'user_identifiers_private', 'myapp_user_identifiers_private', 'user_identifiers_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fa2a1-7000-79ef-8856-c21f21a53591', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'logging_public', 'myapp_logging_public', 'logging_public', NULL, NULL, 'app', '{}', true, 'exposable');


SET session_replication_role TO DEFAULT;


