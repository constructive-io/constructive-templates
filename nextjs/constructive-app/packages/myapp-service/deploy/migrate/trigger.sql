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
  ('019feb75-790d-7126-975c-79ef2d49215c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78e2-720e-82dc-c3ed84264ce8', 'users_search_tsv_tsv_insert_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-790d-75b1-b660-407efc6fa686', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78e2-720e-82dc-c3ed84264ce8', 'users_search_tsv_tsv_update_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-7b8c-7341-8f7a-bf4b1412c140', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b6d-72f4-9506-d4f1cf2023b7', 'peoplestamps_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-7ba3-7b67-bb06-8af698a5a3ca', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b8c-7674-8aa6-9f3e7822b6d2', 'peoplestamps_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-8104-71ca-ad2f-54dad46ea45c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-80eb-77cb-b434-9214851f2d3f', 'peoplestamps_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-811c-7f52-865f-9f6d269019e1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8104-74c1-9285-19272f3f36c9', 'peoplestamps_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-8159-7558-ab7a-9b2cbfa85a3c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8141-7843-8e56-03ed77e58e70', 'peoplestamps_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-8162-75ea-b035-127043849dc7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78e2-720e-82dc-c3ed84264ce8', '_00050_users_org_membership_settings_seed_trg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-843c-7dd7-9765-071d372376be', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78e2-720e-82dc-c3ed84264ce8', '_00060_users_org_profile_templates_seed_trg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-8945-7b88-b9c6-d6c866f8b812', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-891b-7bcd-9ed3-1fc29a40c6cd', 'user_secrets_update_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-8945-7c97-bbd1-dd39117e6247', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-891b-7bcd-9ed3-1fc29a40c6cd', 'user_secrets_insert_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-89bc-7406-8c29-92f422602556', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8966-7ecd-bc75-e2778b51a789', 'app_internal_secrets_update_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-89bc-74da-a22f-84fac1175163', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8966-7ecd-bc75-e2778b51a789', 'app_internal_secrets_insert_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-9109-7967-a557-188cd2df12d3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8713-7ceb-a1b7-6f4fffe21b51', 'app_settings_auth_guard_step_up_upd_tg', NULL, 'app_settings_auth_guard_step_up_upd_fn', NULL, 'auth', '{guard_step_up}'),
  ('019feb75-912a-7178-b912-98280286dad7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8713-7ceb-a1b7-6f4fffe21b51', 'app_settings_auth_guard_step_up_del_tg', NULL, 'app_settings_auth_guard_step_up_del_fn', NULL, 'auth', '{guard_step_up}'),
  ('019feb75-9132-7725-ba41-e4fbd0b5e5fb', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b7e-7a85-9b53-09c3e40fc17e', 'identity_providers_guard_step_up_upd_tg', NULL, 'identity_providers_guard_step_up_upd_fn', NULL, 'auth', '{guard_step_up}'),
  ('019feb75-9146-75fc-aa9d-6ddb68c82b81', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b7e-7a85-9b53-09c3e40fc17e', 'identity_providers_guard_step_up_del_tg', NULL, 'identity_providers_guard_step_up_del_fn', NULL, 'auth', '{guard_step_up}'),
  ('019feb75-9247-729b-9b98-67bc94d14cdc', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9149-78eb-8455-bb07f20208c6', 'principals_guard_step_up_upd_tg', NULL, 'principals_guard_step_up_upd_fn', NULL, 'auth', '{guard_step_up}'),
  ('019feb75-9250-78c0-9d99-cc4bb2de1448', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-91bb-7f0a-9d9d-fd451ffa01f4', 'principal_scope_overrides_guard_step_up_upd_tg', NULL, 'principal_scope_overrides_guard_step_up_upd_fn', NULL, 'auth', '{guard_step_up}'),
  ('019feb75-9257-747b-a082-c330730e30d0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-91bb-7f0a-9d9d-fd451ffa01f4', 'principal_scope_overrides_guard_step_up_del_tg', NULL, 'principal_scope_overrides_guard_step_up_del_fn', NULL, 'auth', '{guard_step_up}'),
  ('019feb75-931d-7bfb-ac40-1c1d086d4368', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92cb-7779-a574-9f45714317cb', 'app_buckets_force_current_user_actor_id_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-9323-74c9-9d30-70688a63c43d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92cb-7779-a574-9f45714317cb', 'app_buckets_immutable_fields_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-9384-7dec-a0a9-35a6df4dae97', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9326-7582-bae6-2409b3215b5d', 'app_files_inherit_from_parent_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-9388-73ce-a950-78ef9c1366da', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9326-7582-bae6-2409b3215b5d', 'app_files_force_current_user_actor_id_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-938c-7312-ac84-f9d21c9b5cdf', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9326-7582-bae6-2409b3215b5d', 'app_files_immutable_fields_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-939c-78b1-b444-0d6635705918', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92cb-7779-a574-9f45714317cb', 'app_buckets_staging_guard_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-93a5-7902-9bfb-fa310041120b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9326-7582-bae6-2409b3215b5d', 'app_files_promotion_guard_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019feb75-93b1-7bb2-a27c-9e9f3a03376e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9326-7582-bae6-2409b3215b5d', 'app_files_gc_storage_object_tg', NULL, NULL, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


