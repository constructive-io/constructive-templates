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
  ('019feb75-784c-7932-a3b6-33342f1bff0c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_public', 'myapp_app_public', 'app_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019feb75-784d-7576-93a4-c922966ef5da', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_private', 'myapp_app_private', 'app_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019feb75-78d6-7cd0-9533-31bd8de066b8', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'users_public', 'myapp_users_public', 'users_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019feb75-7938-77e1-8f66-717a7e6e05de', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'memberships_public', 'myapp_memberships_public', 'memberships_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019feb75-7969-7069-ae1a-42277e7befea', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'capabilities_public', 'myapp_capabilities_public', 'capabilities_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019feb75-7970-7957-8ea7-b79d4615b62c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'capabilities_private', 'myapp_capabilities_private', 'capabilities_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019feb75-79b4-722d-bbc4-c5ef8a53db6b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'limits_public', 'myapp_limits_public', 'limits_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019feb75-79bc-73be-9da4-a0da9c33a7fc', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'limits_private', 'myapp_limits_private', 'limits_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019feb75-7b5c-710b-a201-95a6bb0962be', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'memberships_private', 'myapp_memberships_private', 'memberships_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019feb75-7ca3-764e-895e-58b77d9a5f1d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'profiles_public', 'myapp_profiles_public', 'profiles_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019feb75-7cac-7b80-82dd-d18a956a7fdc', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'profiles_private', 'myapp_profiles_private', 'profiles_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019feb75-8658-74d1-9931-76da2692e55d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'store_private', 'myapp_store_private', 'store_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019feb75-8695-7e24-8b0b-8db166cbaf4a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'auth_private', 'myapp_auth_private', 'auth_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019feb75-895b-7b97-b98f-01b51196320f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'store_public', 'myapp_store_public', 'store_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'auth_public', 'myapp_auth_public', 'auth_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019feb75-8a0e-7a45-8898-85dfd6f8e078', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'user_identifiers_public', 'myapp_user_identifiers_public', 'user_identifiers_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019feb75-8a17-7f4e-89e7-80c6ce5095d1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'user_identifiers_private', 'myapp_user_identifiers_private', 'user_identifiers_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019feb75-8be9-73c3-b3e4-bf7ac46b5d76', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'invites_public', 'myapp_invites_public', 'invites_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019feb75-8bf4-70ee-94b8-840941a142ac', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'invites_private', 'myapp_invites_private', 'invites_private', NULL, NULL, 'app', '{}', false, 'never_expose'),
  ('019feb75-8d96-7cbf-ad3f-be66a626a045', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'logging_public', 'myapp_logging_public', 'logging_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019feb75-92b6-7057-b8de-bd46f3aaef00', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'storage_public', 'myapp_storage_public', 'storage_public', NULL, NULL, 'app', '{}', true, 'exposable'),
  ('019feb75-92c0-733c-80f8-574ce7b97940', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'storage_private', 'myapp_storage_private', 'storage_private', NULL, NULL, 'app', '{}', false, 'never_expose');


SET session_replication_role TO DEFAULT;


