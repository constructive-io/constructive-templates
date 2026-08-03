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
  ('019fbc96-84dd-714a-9115-59c358d447fd', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_public', 'myapp_app_public', 'app_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fbc96-84dd-7a35-9480-d77f89efe0ee', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_private', 'myapp_app_private', 'app_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fbc96-8518-71f6-b5dd-e68f7390e1e2', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'users_public', 'myapp_users_public', 'users_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fbc96-85d4-7f68-b449-545fb41b37d8', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'memberships_public', 'myapp_memberships_public', 'memberships_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fbc96-862f-76db-9baa-23b094401fe1', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'permissions_public', 'myapp_permissions_public', 'permissions_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fbc96-8643-7a6d-8e04-033c76db6ad6', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'permissions_private', 'myapp_permissions_private', 'permissions_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fbc96-86cf-7ef2-a529-3dd72c52bfad', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'limits_public', 'myapp_limits_public', 'limits_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fbc96-86e7-79b0-a4ec-3be5025c1b2e', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'limits_private', 'myapp_limits_private', 'limits_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fbc96-8a81-7f7c-a48a-5a22ff96b8b1', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'memberships_private', 'myapp_memberships_private', 'memberships_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fbc96-8e34-7092-8399-48a2a3e2d57a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'profiles_public', 'myapp_profiles_public', 'profiles_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fbc96-8e55-7985-8a70-cd6ede5e4c5c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'profiles_private', 'myapp_profiles_private', 'profiles_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fbc96-ad22-7c7e-a51b-2988c7c7d29f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'store_private', 'myapp_store_private', 'store_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fbc96-ae06-75fc-96c3-df2484d13ce6', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'auth_private', 'myapp_auth_private', 'auth_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fbc96-beef-7f41-8222-679237757808', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'store_public', 'myapp_store_public', 'store_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fbc96-c130-7558-9bec-78482a963cfe', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'auth_public', 'myapp_auth_public', 'auth_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fbc96-c1c4-7d76-8017-c296fd0375c5', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'user_identifiers_public', 'myapp_user_identifiers_public', 'user_identifiers_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fbc96-c208-7fd4-a19a-6650fdd93969', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'user_identifiers_private', 'myapp_user_identifiers_private', 'user_identifiers_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fbc96-cb64-72af-8517-bb56ec9a9e4a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'invites_public', 'myapp_invites_public', 'invites_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fbc96-cbab-7606-911c-c330b58955f9', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'invites_private', 'myapp_invites_private', 'invites_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019fbc96-d3d8-7d28-be68-51cccf808408', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'logging_public', 'myapp_logging_public', 'logging_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fbc96-ded7-7d8d-9998-193c21acc329', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'storage_public', 'myapp_storage_public', 'storage_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019fbc96-df2f-79b3-963a-81da5c02e36c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'storage_private', 'myapp_storage_private', 'storage_private', NULL, NULL, 'app', '{}', false, 'never_expose');


SET session_replication_role TO DEFAULT;


