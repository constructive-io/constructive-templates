-- Deploy: migrate/trigger
-- made with <3 @ constructive.io

-- requires: migrate/table_grant


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

INSERT INTO metaschema_public.trigger (
  id,
  database_id,
  table_id,
  name,
  event,
  function_name,
  smart_tags,
  category,
  tags
) VALUES
  ('019fc104-f342-7c08-9a85-e8d5225e60ab', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'users_search_tsv_tsv_insert_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fc104-f342-7f42-93d7-019b03dfb362', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'users_search_tsv_tsv_update_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fc104-f919-75a0-8fbb-93deedf30d5c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8d1-7179-8d86-1ce7702d0104', 'peoplestamps_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fc104-f959-72bf-8570-4a73f24394ef', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f919-7c68-b65c-ead0b86f3cc4', 'peoplestamps_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fc105-0a35-7875-b953-035197ea1ccf', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0996-7bb7-8ecb-595462857b72', 'user_secrets_update_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fc105-0a35-7964-a787-0bd61b551bd6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0996-7bb7-8ecb-595462857b72', 'user_secrets_insert_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fc105-0be6-797e-977a-69ea5cb133a6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a8c-74f6-873c-134a7419f69c', 'app_internal_secrets_update_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fc105-0be6-7a52-b727-a510ecc852bb', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a8c-74f6-873c-134a7419f69c', 'app_internal_secrets_insert_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fc105-166d-7485-8394-3d744e0fb8e1', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-00c9-74c6-8795-eb7e04e1c73c', 'app_settings_auth_guard_step_up_upd_tg', NULL, 'app_settings_auth_guard_step_up_upd_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fc105-1730-7114-8717-2d7677250743', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-00c9-74c6-8795-eb7e04e1c73c', 'app_settings_auth_guard_step_up_del_tg', NULL, 'app_settings_auth_guard_step_up_del_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fc105-173f-7fa4-9940-cb83c021eb0f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1171-72ca-849a-5ad7ac0b2fd3', 'identity_providers_guard_step_up_upd_tg', NULL, 'identity_providers_guard_step_up_upd_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fc105-17de-7e6c-af37-3ea6f41b3558', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1171-72ca-849a-5ad7ac0b2fd3', 'identity_providers_guard_step_up_del_tg', NULL, 'identity_providers_guard_step_up_del_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fc105-1adc-7c6d-8400-fba073cf0418', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-17e6-7798-944f-48a70446be95', 'principals_guard_step_up_upd_tg', NULL, 'principals_guard_step_up_upd_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fc105-1b08-707d-a4ec-7f763603d5f7', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-19cc-790a-b75f-2797f5dd0ac3', 'principal_scope_overrides_guard_step_up_upd_tg', NULL, 'principal_scope_overrides_guard_step_up_upd_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fc105-1b32-7e80-afb6-b55ad62ec646', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-19cc-790a-b75f-2797f5dd0ac3', 'principal_scope_overrides_guard_step_up_del_tg', NULL, 'principal_scope_overrides_guard_step_up_del_fn', NULL, 'auth', '{guard_step_up}');


SET session_replication_role TO DEFAULT;


