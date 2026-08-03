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
  ('019fbc96-857d-7a08-a500-982bd1712c85', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'users_search_tsv_tsv_insert_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-857d-7c49-81c4-064f0a83fe32', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'users_search_tsv_tsv_update_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-8aea-74c3-b1ea-8284800f09e4', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8aa7-7512-9409-53c9aa016b84', 'peoplestamps_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-8b25-72c1-8f95-1926dcbbc654', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8aea-7ad4-a849-ea060bfc84a5', 'peoplestamps_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-9a0e-7baa-8208-9650b1ba2298', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-99bc-7201-9cda-85df7f4524ad', 'peoplestamps_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-9a63-79fc-bce9-0195f120ced0', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9a0f-7565-9c5b-19990520d73c', 'peoplestamps_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-9b6b-70a0-bf61-c878e3652249', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9b14-7a84-b273-cc96a45854b8', 'peoplestamps_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-9b8a-7a78-9be1-6c0f32cdd64c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '_00050_users_org_membership_settings_seed_trg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-a671-791e-bd21-3d55fdc3d3d9', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '_00060_users_org_profile_templates_seed_trg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-beb9-7f5d-8b8b-9fae0e15a8b4', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-bdd9-7379-be88-17a73f1d5320', 'user_secrets_update_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-beba-7084-b3f9-44cff6146af3', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-bdd9-7379-be88-17a73f1d5320', 'user_secrets_insert_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-c0e6-7a77-af91-a3dca517170f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-bf36-74c5-8ebc-0fda254875cd', 'app_internal_secrets_update_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-c0e6-7b4e-9671-fd9377123ee7', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-bf36-74c5-8ebc-0fda254875cd', 'app_internal_secrets_insert_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-d769-77e8-86cb-73892bc0810a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b0c6-757d-a948-e13949bc1c55', 'app_settings_auth_guard_step_up_upd_tg', NULL, 'app_settings_auth_guard_step_up_upd_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fbc96-d870-7298-be32-28c584c60846', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b0c6-757d-a948-e13949bc1c55', 'app_settings_auth_guard_step_up_del_tg', NULL, 'app_settings_auth_guard_step_up_del_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fbc96-d885-7483-a9ce-b9c0db3baa58', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c88d-7ba5-bce4-cfcf39ec99a4', 'identity_providers_guard_step_up_upd_tg', NULL, 'identity_providers_guard_step_up_upd_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fbc96-d93f-7956-9fd7-d060e0d32400', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c88d-7ba5-bce4-cfcf39ec99a4', 'identity_providers_guard_step_up_del_tg', NULL, 'identity_providers_guard_step_up_del_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fbc96-de07-7469-a50c-5ec00fc205cc', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-d949-70f9-ae75-050b81c28f49', 'principals_guard_step_up_upd_tg', NULL, 'principals_guard_step_up_upd_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fbc96-de49-75fb-8817-0ff807e67d0d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-dbf8-7743-a147-16f1aad029b3', 'principal_scope_overrides_guard_step_up_upd_tg', NULL, 'principal_scope_overrides_guard_step_up_upd_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fbc96-de7e-7b86-8dc9-f6dfe0bd0c71', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-dbf8-7743-a147-16f1aad029b3', 'principal_scope_overrides_guard_step_up_del_tg', NULL, 'principal_scope_overrides_guard_step_up_del_fn', NULL, 'auth', '{guard_step_up}'),
  ('019fbc96-e156-7ef9-9e63-2b3fb7013edb', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-df8c-7b8f-b346-12f61ba2c1ea', 'app_buckets_force_current_user_actor_id_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-e167-70e9-9b7e-8d9197099016', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-df8c-7b8f-b346-12f61ba2c1ea', 'app_buckets_immutable_fields_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-e399-73be-9add-2bae0d8ef94b', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-e17f-7451-b63a-298e84a64979', 'app_files_inherit_from_parent_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-e3a9-793e-99d7-03f6dd1f8a9c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-e17f-7451-b63a-298e84a64979', 'app_files_force_current_user_actor_id_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-e3b9-7119-a149-0e361c0143d5', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-e17f-7451-b63a-298e84a64979', 'app_files_immutable_fields_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fbc96-e3ef-70c8-b416-ea219ca51b40', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-e17f-7451-b63a-298e84a64979', 'app_files_gc_storage_object_tg', NULL, NULL, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


