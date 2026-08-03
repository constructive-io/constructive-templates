-- Deploy: migrate/trigger_function
-- made with <3 @ constructive.io

-- requires: migrate/schema


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

INSERT INTO metaschema_public.trigger_function (
  id,
  database_id,
  name,
  code
) VALUES
  ('019fbc96-857d-76d8-96cc-28fd9142cdce', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'users_search_tsv_tsv', NULL),
  ('019fbc96-8aea-70c1-bda1-0c82e92d2a9b', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_memberships_peoplestamps', NULL),
  ('019fbc96-8b24-7f34-b4ec-3f208e001c9a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_membership_defaults_peoplestamps', NULL),
  ('019fbc96-9a0e-735f-a8b8-c273b3d90a71', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'org_memberships_peoplestamps', NULL),
  ('019fbc96-9a63-71d1-aec0-a665e0ce41f3', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'org_membership_defaults_peoplestamps', NULL),
  ('019fbc96-9b6a-75ef-afa0-31fd6e90038a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'org_membership_settings_peoplestamps', NULL),
  ('019fbc96-9b8a-722c-addc-18b2e7bab622', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'org_membership_settings_seed_fn', NULL),
  ('019fbc96-a670-7e3d-8106-069fd04fe0c4', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'org_profile_templates_seed_fn', NULL),
  ('019fbc96-beb8-7dec-9f2c-f624977083d3', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'user_secrets_hash', NULL),
  ('019fbc96-c0e5-77bf-bf45-d0007e2a128c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_internal_secrets_hash', NULL),
  ('019fbc96-d768-737c-9da9-ef681725af40', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_settings_auth_guard_step_up_upd_fn', NULL),
  ('019fbc96-d86e-7e81-ba23-34cc22578f96', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_settings_auth_guard_step_up_del_fn', NULL),
  ('019fbc96-d883-7e43-8a9f-af03226db029', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'identity_providers_guard_step_up_upd_fn', NULL),
  ('019fbc96-d93e-73b1-b2a8-0ec112b8008a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'identity_providers_guard_step_up_del_fn', NULL),
  ('019fbc96-de05-7f76-bb6e-2ad409db8c30', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'principals_guard_step_up_upd_fn', NULL),
  ('019fbc96-de48-7258-ba58-ff1d2f4b5abc', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'principal_scope_overrides_guard_step_up_upd_fn', NULL),
  ('019fbc96-de7d-77ff-8f71-8155d87a7ab6', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'principal_scope_overrides_guard_step_up_del_fn', NULL),
  ('019fbc96-e155-78e4-8d22-9459cba49343', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_buckets_force_current_user_actor_id', NULL),
  ('019fbc96-e165-7c08-9691-8fe6efb2a905', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_buckets_immutable_fields', NULL),
  ('019fbc96-e397-7cca-86b7-77b8c3acceb9', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_files_inherit_from_parent', NULL),
  ('019fbc96-e3a8-7349-9b03-350cfe03e6a2', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_files_force_current_user_actor_id', NULL),
  ('019fbc96-e3b7-7bf6-96fc-8e056485d4d6', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_files_immutable_fields', NULL),
  ('019fbc96-e3ed-7c24-be7c-bf0f7bcadc79', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'app_files_gc_storage_object', NULL);


SET session_replication_role TO DEFAULT;


