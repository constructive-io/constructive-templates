-- Deploy: migrate/index
-- made with <3 @ constructive.io

-- requires: migrate/full_text_search


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

INSERT INTO metaschema_public.index (
  id,
  database_id,
  table_id,
  name,
  field_ids,
  include_field_ids,
  access_method,
  index_params,
  where_clause,
  is_unique,
  options,
  op_classes,
  smart_tags,
  category,
  tags
) VALUES
  ('019fc104-f343-7559-ac1f-36f52b8bb55f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'users_search_tsv_gin_idx', '{019fc104-f332-74a2-980b-1b04d6073993}', '{}', 'GIN', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-f36d-71d0-97aa-1afe8dce1d7d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'users_type_idx', '{019fc104-f360-73a5-84f9-f29b901a6f66}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-f50f-78c3-b3e1-6cacf04fac0c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4e1-7642-9736-e6d5dfaceeac', 'app_limits_actor_id_idx', '{019fc104-f503-75a1-97a1-e45b646df2f6}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-f5b9-781e-8e03-cf67497a6189', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f597-75f3-a67f-5fbd5f0e3faa', 'app_limit_credits_default_limit_id_idx', '{019fc104-f5ad-7e07-8853-ca6392695c75}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-f5c6-7e7c-8502-a4b96899f43a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f597-75f3-a67f-5fbd5f0e3faa', 'app_limit_credits_actor_id_idx', '{019fc104-f5bd-75d1-b3e0-0f19e5c3546a}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-f71c-718f-8e31-01748011f112', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f6e8-7711-ab24-10ebe24dbe7f', 'app_limit_credit_code_items_default_limit_id_idx', '{019fc104-f70f-73f4-b36d-4a7e6ce74b36}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-f88c-70e6-8044-516f4e4a9cf8', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f856-7ccd-9517-b0ea87623895', 'app_limit_warning_states_actor_id_idx', '{019fc104-f87e-7692-aea7-adc8cd2ec2ba}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-f993-7532-a47c-d2330330affc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f959-78a1-85cf-b54b5e2847b4', 'app_memberships_sprts_actor_id_idx', '{019fc104-f989-7f49-bcb8-1227eb8c7f69}', '{019fc104-f97b-7921-bbc4-6e7654f3913a,019fc104-f965-7264-b5c7-3e83dc57016c,019fc104-f970-78f6-b69d-0e85d2dfb84a}', 'BTREE', NULL, NULL, true, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-fa7f-7cbd-83dc-08527e373d54', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fa51-7cc1-86be-cc37ef1d2058', 'app_admin_grants_actor_id_idx', '{019fc104-fa75-7680-9339-a286d26ef3d7}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-fa8f-7afd-9b94-2f8ffa8bd556', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fa51-7cc1-86be-cc37ef1d2058', 'app_admin_grants_grantor_id_idx', '{019fc104-fa84-7053-911b-f7c8bc31ca6a}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-fadb-72aa-a430-331a175c91b6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-faa9-779d-997d-b63d69f26665', 'app_owner_grants_actor_id_idx', '{019fc104-facf-7ba9-a376-43d9f3d0f2e0}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-faea-76c3-a39b-fc971aac973a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-faa9-779d-997d-b63d69f26665', 'app_owner_grants_grantor_id_idx', '{019fc104-fadf-7245-8a83-432ed1593ff7}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-fb40-7b74-9d4e-d8b002f3c52e', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb03-7075-b98c-fc2016e45ebb', 'app_grants_actor_id_idx', '{019fc104-fb35-73c7-ba78-6de47a7363ab}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-fb50-794b-b13f-33a26861179f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb03-7075-b98c-fc2016e45ebb', 'app_grants_grantor_id_idx', '{019fc104-fb44-7c3d-b153-cb13e031bd12}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-fbd8-7e4a-acf1-1a552f1a6b58', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fbb0-7857-99af-321fc43e416c', 'app_permission_default_grants_permission_id_idx', '{019fc104-fbca-74b2-999e-6090825fa4c5}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-fbf6-7cd8-8441-86a175758016', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fbb0-7857-99af-321fc43e416c', 'app_permission_default_grants_grantor_id_idx', '{019fc104-fbea-7548-90cc-17007f8aba54}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc104-ffcd-772a-ba7c-602ba625c618', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-ff05-737a-9287-9dc91676dc85', 'sessions_user_id_idx', '{019fc104-ff2b-7286-ab0b-4375a74ce057}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-00bc-790f-a768-040628e8bf71', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-ffd2-7869-bc0e-15e9e9f99044', 'session_credentials_session_id_idx', '{019fc104-fff0-777a-bfd4-3cd226a02598}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-00c1-70be-9461-ac50cf42836d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-ffd2-7869-bc0e-15e9e9f99044', 'session_credentials_kind_idx', '{019fc104-fffa-7d56-8410-ec1b1b6ebe7a}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-04a7-7807-85db-e7a73b8efa79', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0471-784c-9f94-cb05526be1f0', 'session_secrets_session_id_idx', '{019fc105-0492-78a1-8d83-91add7441eca}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-06b1-70ed-9788-e0b9f5389779', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0611-7e5d-8c39-47e53c2a80d2', 'auth_ip_rate_limits_ip_address_idx', '{019fc105-0633-736a-853d-c04d7a32fd7d}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-06b6-7d5e-89d6-b3ca9f2e0324', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0611-7e5d-8c39-47e53c2a80d2', 'auth_ip_rate_limits_locked_until_idx', '{019fc105-067e-7530-8464-f7e1cd4861b9}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-0753-7162-bc27-ccec9e01fcc7', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-06bc-74e6-9286-763950a36e86', 'auth_rate_limits_subject_id_idx', '{019fc105-06df-78d9-9483-143575786201}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-075a-7c40-9e85-7912b8633f63', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-06bc-74e6-9286-763950a36e86', 'auth_rate_limits_locked_until_idx', '{019fc105-0724-7e69-9bc8-d96004579ea1}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-0965-737a-8e6a-686a59b6786d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0837-7cb1-9c78-199827e949c6', 'auth_user_devices_user_id_idx', '{019fc105-085b-75cc-a095-c1e20639fec2}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-096a-7f6d-b3fa-afc31ee11e81', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0837-7cb1-9c78-199827e949c6', 'auth_user_devices_device_token_hash_idx', '{019fc105-0869-7f53-91ed-ac2262cf8c32}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-0970-7838-871b-cf6879dbba85', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0837-7cb1-9c78-199827e949c6', 'auth_user_devices_trust_expires_at_idx', '{019fc105-091c-7ac3-9379-b5c20233e5bb}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-0d3d-7fdd-9f9d-68c35723bc4b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cf6-7075-9d35-6b418c5f8913', 'emails_owner_id_idx', '{019fc105-0d25-7002-9320-e0a575962d45}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-0e51-7563-ac2d-066da405cd23', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0e13-7f38-9a06-598fb71d8c7b', 'phone_numbers_owner_id_idx', '{019fc105-0e3a-778e-a521-c3b15353254f}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-0f6d-76fd-9fc3-2839ad5a5c5c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0f2e-795d-b36f-44859808a931', 'webauthn_credentials_owner_id_idx', '{019fc105-0f56-74a7-98eb-fb4884d24331}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-10af-7952-93f3-0ab94f98f7fd', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-106d-7a9f-9f9f-9b50b89450ca', 'connected_accounts_owner_id_idx', '{019fc105-1097-7566-8fb3-51baa26f1af9}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-144e-7c55-9075-0cc1ab7e8534', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-13bf-7b4a-919a-37a5c5871c02', 'audit_log_auths_event_idx', '{019fc105-13f2-720b-913a-dc78a52f6eb1}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-1462-73f6-8c88-0666800070b4', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-13bf-7b4a-919a-37a5c5871c02', 'audit_log_auths_actor_id_idx', '{019fc105-1406-7506-9271-db6f74e65431}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-18d4-73a6-9ae5-a61c743ef688', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-17e6-7798-944f-48a70446be95', 'principals_owner_id_idx', '{019fc105-183d-7e3c-be53-445348ffc9e1}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-18db-7594-97f6-317cfd404ac0', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-17e6-7798-944f-48a70446be95', 'principals_user_id_idx', '{019fc105-1858-7148-ac13-eb231c4a3b46}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-1997-7dbb-be3c-8db641f81015', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-18e2-7443-87f5-499f34c69054', 'principal_entities_principal_id_idx', '{019fc105-193a-7dcf-b04b-944456f3fcfc}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-199e-701e-ad12-64dff7aa526b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-18e2-7443-87f5-499f34c69054', 'principal_entities_entity_id_idx', '{019fc105-1958-736a-a089-bbf4a4c492a0}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-19a3-7e54-83b3-d404e2cde334', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-18e2-7443-87f5-499f34c69054', 'principal_entities_owner_id_idx', '{019fc105-1972-7a87-9a7b-35c6b5c15faa}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fc105-1ab6-75fc-baa6-99414870dbd8', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-19cc-790a-b75f-2797f5dd0ac3', 'principal_scope_overrides_principal_id_idx', '{019fc105-1a25-728f-8eaf-e99a02fd9dac}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


