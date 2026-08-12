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
  ('019fc104-f342-780c-9770-907460b5e11f', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'users_search_tsv_tsv', NULL),
  ('019fc104-f919-7099-8ffd-009ef07bc90f', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'app_memberships_peoplestamps', NULL),
  ('019fc104-f958-7f0d-9eb7-04b7f1789624', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'app_membership_defaults_peoplestamps', NULL),
  ('019fc105-0a34-7d0c-ab19-7125a03a3063', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'user_secrets_hash', NULL),
  ('019fc105-0be5-7d88-b471-000131071980', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'app_internal_secrets_hash', NULL),
  ('019fc105-166c-77ea-b5a6-60357e9d7e70', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'app_settings_auth_guard_step_up_upd_fn', NULL),
  ('019fc105-172f-745f-94ab-972752bdeb7d', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'app_settings_auth_guard_step_up_del_fn', NULL),
  ('019fc105-173f-73c0-8252-2f8ca78b2339', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'identity_providers_guard_step_up_upd_fn', NULL),
  ('019fc105-17de-7195-bdd7-efd821d8e309', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'identity_providers_guard_step_up_del_fn', NULL),
  ('019fc105-1adb-7fdf-a172-d2f7b3f2610f', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'principals_guard_step_up_upd_fn', NULL),
  ('019fc105-1b07-73be-94d8-30cc687d6fa3', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'principal_scope_overrides_guard_step_up_upd_fn', NULL),
  ('019fc105-1b32-7235-a139-88a07e94a078', '019fc104-f28d-7b9c-8d9d-8f338def573c', 'principal_scope_overrides_guard_step_up_del_fn', NULL);


SET session_replication_role TO DEFAULT;


