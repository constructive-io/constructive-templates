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
  ('019fc104-f294-70c5-a245-14fc6887a0dd', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'app_public', 'myapp_app_public', 'app_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fc104-f294-7a40-b992-5faed1bc8194', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'app_private', 'myapp_app_private', 'app_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'users_public', 'myapp_users_public', 'users_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fc104-f39c-7300-895c-30b0b61a670e', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'memberships_public', 'myapp_memberships_public', 'memberships_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fc104-f3fb-7199-84be-973cb5027963', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'permissions_public', 'myapp_permissions_public', 'permissions_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fc104-f410-7e31-8f42-b46383f39596', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'permissions_private', 'myapp_permissions_private', 'permissions_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fc104-f4a9-7dad-b8d1-37fc33a66117', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'limits_public', 'myapp_limits_public', 'limits_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fc104-f4c1-7d26-9e70-bc3cc5757a99', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'limits_private', 'myapp_limits_private', 'limits_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fc104-f8a8-7507-a922-39132d5dfbe9', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'memberships_private', 'myapp_memberships_private', 'memberships_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fc104-fe4d-756f-a748-ecfa3f8cb05b', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'store_private', 'myapp_store_private', 'store_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fc104-fee2-7758-ae40-4fdc60702a9e', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'auth_private', 'myapp_auth_private', 'auth_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fc105-0a5d-726d-81e3-16720f03bcfa', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'store_public', 'myapp_store_public', 'store_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fc105-0c1b-7bde-9736-c30b1029bcc9', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'auth_public', 'myapp_auth_public', 'auth_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fc105-0c8d-72ee-983e-7d7c1610c7f5', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'user_identifiers_public', 'myapp_user_identifiers_public', 'user_identifiers_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fc105-0cbe-7083-b3b1-f8ed102c2bb0', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'user_identifiers_private', 'myapp_user_identifiers_private', 'user_identifiers_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fc105-1384-729e-90a7-7b2eadef8142', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'logging_public', 'myapp_logging_public', 'logging_public', NULL, NULL, 'app', '{}', true, 'exposable');


SET session_replication_role TO DEFAULT;


