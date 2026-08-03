-- Deploy: migrate/unique_constraint
-- made with <3 @ constructive.io

-- requires: migrate/trigger


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

INSERT INTO metaschema_public.unique_constraint (
  id,
  database_id,
  table_id,
  name,
  description,
  smart_tags,
  type,
  field_ids,
  without_overlaps,
  is_deferrable,
  initially_deferred,
  category,
  tags
) VALUES
  ('019fbc96-855c-7ed0-8810-043be06eff1a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'users_username_key', NULL, NULL, 'u', '{019fbc96-8552-7c53-8c92-5ad667e6d165}', false, false, false, 'app', '{}'),
  ('019fbc96-8599-7855-b65d-80e4efb135f7', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8583-7576-a215-4812842342ee', 'role_types_name_key', NULL, NULL, 'u', '{019fbc96-8593-7645-a3c7-059b4c784581}', false, false, false, 'app', '{}'),
  ('019fbc96-8622-70c0-aaf9-19bc058fa617', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-85ec-719f-bba7-dec8314cc52c', 'membership_types_name_key', NULL, NULL, 'u', '{019fbc96-8603-761a-87db-36ccc1a454d5}', false, false, false, 'app', '{}'),
  ('019fbc96-8679-78e2-a8de-75b5742f5e08', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-865b-7f26-a4f8-32df18a9e0ae', 'app_permissions_name_key', NULL, NULL, 'u', '{019fbc96-8674-705a-b067-557cdfcd24ff}', false, false, false, 'app', '{}'),
  ('019fbc96-8687-72db-bc09-3301ee65d9e1', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-865b-7f26-a4f8-32df18a9e0ae', 'app_permissions_bitnum_key', NULL, NULL, 'u', '{019fbc96-867d-7070-9d38-27dda4bbdec8}', false, false, false, 'app', '{}'),
  ('019fbc96-875f-7411-8071-b86b0328174c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8702-7a94-9e81-560580adcaeb', 'app_limits_name_actor_id_key', NULL, NULL, 'u', '{019fbc96-871b-76a5-aed2-63ed04389d53,019fbc96-8721-704b-909a-6c44dae8ff41}', false, false, false, 'app', '{}'),
  ('019fbc96-8791-7dd9-8bfe-28db44a4d9f5', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-876c-7f34-b3b2-19c7fbae3f4f', 'app_limit_defaults_name_key', NULL, NULL, 'u', '{019fbc96-8780-783a-a7d6-ab25bf057f06}', false, false, false, 'app', '{}'),
  ('019fbc96-88bf-7fbc-9235-6fc8c84310d7', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-88a2-7bb3-a792-7deab9133c17', 'app_limit_credit_codes_code_key', NULL, NULL, 'u', '{019fbc96-88b7-742c-a16b-828c174f5314}', false, false, false, 'app', '{}'),
  ('019fbc96-892b-7547-baed-db9303c2b1e7', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-88e4-7573-883d-6076b169c481', 'app_limit_credit_code_items_credit_code_id_default_limit_id_key', NULL, NULL, 'u', '{019fbc96-88fb-7cca-a275-8abe88e10a5c,019fbc96-8908-7234-bb77-c634e220135f}', false, false, false, 'app', '{}'),
  ('019fbc96-8971-7b25-8493-9358be8183f6', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-893b-70db-9825-27d695d8acfe', 'app_limit_credit_redemptions_credit_code_id_entity_id_key', NULL, NULL, 'u', '{019fbc96-894f-7db9-a520-041e3c0fb1f9,019fbc96-895c-77eb-8ed3-e05fa380605d}', false, false, false, 'app', '{}'),
  ('019fbc96-89b1-716b-ac4a-c4c43bd87b0f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8985-7211-b337-533f1418ea53', 'app_limit_caps_defaults_name_key', NULL, NULL, 'u', '{019fbc96-899b-74e4-b930-2166be24dc33}', false, false, false, 'app', '{}'),
  ('019fbc96-89ea-7104-b062-528563a884b4', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-89b5-7647-9922-f83e63461d5e', 'app_limit_caps_name_entity_id_key', NULL, NULL, 'u', '{019fbc96-89ce-7090-87e3-f8d0074a67f2,019fbc96-89d7-770d-8093-bd4b0053d207}', false, false, false, 'app', '{}'),
  ('019fbc96-8a32-7223-bbd9-ef4ce7722da7', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-89f9-77bd-ada7-8458562dae38', 'app_limit_warnings_name_key', NULL, NULL, 'u', '{019fbc96-8a0f-7409-b354-db8cee75b7fe}', false, false, false, 'app', '{}'),
  ('019fbc96-8a73-7df6-9ee3-eda27f18fdd4', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8a36-72d6-9f45-a72f2e3d7f45', 'app_limit_warning_states_warning_id_actor_id_key', NULL, NULL, 'u', '{019fbc96-8a4b-7cf5-b2e0-78600b038279,019fbc96-8a58-7a91-af87-e278c560bf3d}', false, false, false, 'app', '{}'),
  ('019fbc96-8bfd-7d27-a71c-abacc654715d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8aa7-7512-9409-53c9aa016b84', 'app_memberships_actor_id_key', NULL, NULL, 'u', '{019fbc96-8bed-7fae-8300-758f77324497}', false, false, false, 'app', '{}'),
  ('019fbc96-8d72-7ff7-90b4-7922ebf9ddda', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8d4b-7d3e-b20b-ecb9ad31487d', 'app_permission_default_permissions_permission_id_key', NULL, NULL, 'u', '{019fbc96-8d64-7cae-8dc2-625be2c530cd}', false, false, false, 'app', '{}'),
  ('019fbc96-8efc-72ce-a55b-a7ee882cb818', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8e7e-7b0d-8c4a-b7c306b27a4e', 'app_profiles_name_key', NULL, NULL, 'u', '{019fbc96-8e9e-7292-b686-c04a223e6ff7}', false, false, false, 'app', '{}'),
  ('019fbc96-8f01-77d3-b81f-09c4ff5fb391', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8e7e-7b0d-8c4a-b7c306b27a4e', 'app_profiles_slug_key', NULL, NULL, 'u', '{019fbc96-8ea9-7a78-b1c8-e9eb1d01a2da}', false, false, false, 'app', '{}'),
  ('019fbc96-8f51-701e-bdcf-5a0810d71084', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8f0f-7a36-991e-55003b1a091b', 'app_profile_permissions_profile_id_permission_id_key', NULL, NULL, 'u', '{019fbc96-8f2b-7077-9496-739a0f735158,019fbc96-8f3b-77b5-a4cc-93ac8296dc09}', false, false, false, 'app', '{}'),
  ('019fbc96-9107-7807-aa00-8a0bea593e2d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9098-7c7b-a3d2-0a6ca2ae13dd', 'app_profile_templates_name_key', NULL, NULL, 'u', '{019fbc96-90b5-79de-b881-cab6eb396f2b}', false, false, false, 'app', '{}'),
  ('019fbc96-910c-75a8-baa3-84d7182e3c3a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9098-7c7b-a3d2-0a6ca2ae13dd', 'app_profile_templates_slug_key', NULL, NULL, 'u', '{019fbc96-90c1-786f-9f07-115a51a30355}', false, false, false, 'app', '{}'),
  ('019fbc96-93f2-7528-816a-f8ec10ca607c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-93c9-79f2-8dcb-8d72b5725eaa', 'org_permissions_name_key', NULL, NULL, 'u', '{019fbc96-93e9-7350-989f-af265b7ebdc0}', false, false, false, 'app', '{}'),
  ('019fbc96-9405-7273-8f72-236b63244089', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-93c9-79f2-8dcb-8d72b5725eaa', 'org_permissions_bitnum_key', NULL, NULL, 'u', '{019fbc96-93f7-7561-8ea2-a61685c18c0d}', false, false, false, 'app', '{}'),
  ('019fbc96-952c-7a41-b419-5df119ee8073', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-948e-7191-adb1-ab09ac90689e', 'org_limits_name_actor_id_entity_id_key', NULL, NULL, 'u', '{019fbc96-94ae-7874-8def-a3ce9f822fb4,019fbc96-94b8-72bd-8a00-3fa635286258,019fbc96-9518-78d9-bded-0d625ae0ccdf}', false, false, false, 'app', '{}'),
  ('019fbc96-957d-7457-a068-b0fe03d5bd14', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9542-74ef-b1d3-8502bfd69283', 'org_limit_defaults_name_key', NULL, NULL, 'u', '{019fbc96-9560-793b-a5b5-6a1c52826264}', false, false, false, 'app', '{}'),
  ('019fbc96-9702-7a3d-8690-a13e29035666', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9653-7e0d-9ee8-3eaed61a69d2', 'org_limit_aggregates_name_entity_id_key', NULL, NULL, 'u', '{019fbc96-9673-7082-aee3-0b1ac98f93e5,019fbc96-967d-768f-94f5-2bfe2f07a6cd}', false, false, false, 'app', '{}'),
  ('019fbc96-984f-7ec0-96e0-33b9546e5f06', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-980d-74f0-ae5e-9ff54538f26e', 'org_limit_caps_defaults_name_key', NULL, NULL, 'u', '{019fbc96-982f-74bd-955e-2cacdaa93cfc}', false, false, false, 'app', '{}'),
  ('019fbc96-98a9-752c-aa0c-4c4265922558', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9855-783c-b950-9c834283e3c8', 'org_limit_caps_name_entity_id_key', NULL, NULL, 'u', '{019fbc96-9878-7ca7-a776-83a09f747bf6,019fbc96-9887-7abe-8605-3d6205494d84}', false, false, false, 'app', '{}'),
  ('019fbc96-9934-79d3-9eeb-35343d06470c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-98c4-7744-8d5a-86dd9eb2b9eb', 'org_limit_warnings_name_entity_id_key', NULL, NULL, 'u', '{019fbc96-98e5-75d4-a569-de359cddb257,019fbc96-991f-7877-b63d-adf6a8f8e401}', false, false, false, 'app', '{}'),
  ('019fbc96-99a6-7c24-9a07-eb498cb0c12a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-993a-79a3-a5c4-2758293cdd9b', 'org_limit_warning_states_warning_id_actor_id_entity_id_key', NULL, NULL, 'u', '{019fbc96-995a-7167-89c3-f66478c4dddb,019fbc96-996d-75a4-9416-112ece65d008,019fbc96-9991-72fc-8e8b-b00645e6f9d2}', false, false, false, 'app', '{}'),
  ('019fbc96-9b0e-7622-b3de-8c9037dd20ee', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9a0f-7565-9c5b-19990520d73c', 'org_membership_defaults_entity_id_key', NULL, NULL, 'u', '{019fbc96-9af9-7391-b0d1-d2d7bbad2eaa}', false, false, false, 'app', '{}'),
  ('019fbc96-9b80-727b-b1f7-d80e529361dd', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9b14-7a84-b273-cc96a45854b8', 'org_membership_settings_entity_id_key', NULL, NULL, 'u', '{019fbc96-9b6b-7ba0-810f-073e3be39201}', false, false, false, 'app', '{}'),
  ('019fbc96-9ce8-703e-b85c-8d5edd689a33', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-99bc-7201-9cda-85df7f4524ad', 'org_memberships_actor_id_entity_id_key', NULL, NULL, 'u', '{019fbc96-9cbb-7a01-8a1a-ad70734140a4,019fbc96-9cd1-75ec-a83a-dcff92c0ed44}', false, false, false, 'app', '{}'),
  ('019fbc96-9d94-7d15-b635-fa7ae5154dd0', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9d0c-7703-9e77-3ad4e99213ab', 'org_members_actor_id_entity_id_key', NULL, NULL, 'u', '{019fbc96-9d40-7a09-a1e5-42d6912de1b0,019fbc96-9d55-7dd6-8d51-9de688cba157}', false, false, false, 'app', '{}'),
  ('019fbc96-9f93-74de-928e-490fa81d02f2', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9f36-7e20-ac14-923b764c3ac4', 'org_member_profiles_membership_id_key', NULL, NULL, 'u', '{019fbc96-9f7c-7e65-8cb9-d02ccd6eef7c}', false, false, false, 'app', '{}'),
  ('019fbc96-a01d-7f06-b602-53166273f2de', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9f36-7e20-ac14-923b764c3ac4', 'org_member_profiles_actor_id_entity_id_key', NULL, NULL, 'u', '{019fbc96-9fb5-7454-8937-30d3e7c189bd,019fbc96-9f99-75d9-ab2d-09a1ef826cd4}', false, false, false, 'app', '{}'),
  ('019fbc96-a35d-76c2-8bb5-dfbda5dddd78', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a293-7833-9a15-03f67f8888d1', 'org_profiles_name_entity_id_key', NULL, NULL, 'u', '{019fbc96-a2b9-7347-b950-9bb1fddd7c84,019fbc96-a345-7ce2-95a8-aeca8c0df93d}', false, false, false, 'app', '{}'),
  ('019fbc96-a364-7585-b1ab-2c0b5c9b3db4', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a293-7833-9a15-03f67f8888d1', 'org_profiles_slug_entity_id_key', NULL, NULL, 'u', '{019fbc96-a2ca-78a1-ae5a-92fe266103e3,019fbc96-a345-7ce2-95a8-aeca8c0df93d}', false, false, false, 'app', '{}'),
  ('019fbc96-a3d5-7baa-a87f-b2aca4f7835b', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a37a-7979-a78d-aec6597cf407', 'org_profile_permissions_profile_id_permission_id_key', NULL, NULL, 'u', '{019fbc96-a3a2-7b03-894c-aa41a8d85569,019fbc96-a3ba-718e-84ed-f47a84766519}', false, false, false, 'app', '{}'),
  ('019fbc96-a653-7849-b1cd-bd772e5aa491', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a5ab-7844-9c3f-26f638f94b2d', 'org_profile_templates_name_key', NULL, NULL, 'u', '{019fbc96-a5d2-742a-86d0-54d4814e27fd}', false, false, false, 'app', '{}'),
  ('019fbc96-a65a-7b7e-857e-4ce92de05c9e', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a5ab-7844-9c3f-26f638f94b2d', 'org_profile_templates_slug_key', NULL, NULL, 'u', '{019fbc96-a5e5-7dd9-a632-d56cea67c34c}', false, false, false, 'app', '{}'),
  ('019fbc96-a722-787a-81b5-da5d157882a7', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-a679-7751-89c9-def7076eb2dc', 'org_chart_edges_entity_id_child_id_key', NULL, NULL, 'u', '{019fbc96-a6c6-77b2-a18b-0335e7ef79ae,019fbc96-a6df-7bea-8786-790764ec62d2}', false, false, false, 'app', '{}'),
  ('019fbc96-adc0-79b7-b721-2f06b55957d8', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ad5b-7116-9f79-d037fdc40cd9', 'user_states_owner_id_name_key', NULL, NULL, 'u', '{019fbc96-ad88-7131-9701-39d3c166b6b5,019fbc96-ad99-7ad5-a222-0c725c2f5e83}', false, false, false, 'app', '{}'),
  ('019fbc96-b09d-791a-9806-f2deb2090784', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-af80-75e3-9b05-4a449fcabc73', 'session_credentials_secret_hash_key', NULL, NULL, 'u', '{019fbc96-afe0-7d40-84af-b6a93bbaf573}', false, false, false, 'app', '{}'),
  ('019fbc96-b0a5-7f75-ad42-e5ac065b5843', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-af80-75e3-9b05-4a449fcabc73', 'session_credentials_key_id_key', NULL, NULL, 'u', '{019fbc96-afd5-7878-ba0d-1e1bbc4f789f}', false, false, false, 'app', '{}'),
  ('019fbc96-b0ad-75fd-96d5-6e5bb845aa7e', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-af80-75e3-9b05-4a449fcabc73', 'session_credentials_ot_token_key', NULL, NULL, 'u', '{019fbc96-b02e-7bda-b589-5449eb664b84}', false, false, false, 'app', '{}'),
  ('019fbc96-b737-717e-b7cd-c28e6aa111d1', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b686-765d-895b-6bf64df652aa', 'session_secrets_session_id_name_key', NULL, NULL, 'u', '{019fbc96-b6b5-7853-9c4b-50277741790c,019fbc96-b6da-74b4-8536-3d8ce9cc90f0}', false, false, false, 'app', '{}'),
  ('019fbc96-b9c7-7dc3-b653-1a2c818a6966', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b8f2-702a-b172-48e604ef0185', 'auth_ip_rate_limits_ip_address_ua_hash_action_key', NULL, NULL, 'u', '{019fbc96-b922-780b-af82-bd3ec0ea81fd,019fbc96-b938-7770-b3b1-522546f19ca0,019fbc96-b951-7af1-9c88-753492718f43}', false, false, false, 'app', '{}'),
  ('019fbc96-baa6-7899-8f9f-d67d730f3165', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b9e0-730a-84ef-3247bb074a9a', 'auth_rate_limits_subject_id_action_key', NULL, NULL, 'u', '{019fbc96-ba10-77fe-9f00-7e4397f84eae,019fbc96-ba23-7951-b0d2-d18e6a6495d1}', false, false, false, 'app', '{}'),
  ('019fbc96-bd8b-7b86-a718-114ca7fb6cd2', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-bbf2-7aef-8d13-b34586d8c5f2', 'auth_user_devices_user_id_device_token_hash_key', NULL, NULL, 'u', '{019fbc96-bc26-71b3-aa22-dd687bc109ae,019fbc96-bc3a-70e4-a56b-35895a9b4e74}', false, false, false, 'app', '{}'),
  ('019fbc96-be80-71f9-84b8-de96c323a136', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-bdd9-7379-be88-17a73f1d5320', 'user_secrets_owner_id_name_key', NULL, NULL, 'u', '{019fbc96-be07-7fbe-9419-3a7fc72a9c26,019fbc96-be1c-77eb-a71f-3450eacaa616}', false, false, false, 'app', '{}'),
  ('019fbc96-c33c-7020-942c-2d464ed7a012', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c250-7c44-b81a-baa69ea7f678', 'emails_email_key', NULL, NULL, 'u', '{019fbc96-c2b6-744c-b3bd-8977f8dcd8cc}', false, false, false, 'app', '{}'),
  ('019fbc96-c4c8-7128-96a9-270d84e4f4e6', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c3eb-7e52-a614-bb88613a1b4d', 'phone_numbers_number_key', NULL, NULL, 'u', '{019fbc96-c46c-7343-841d-bac66451025a}', false, false, false, 'app', '{}'),
  ('019fbc96-c6f2-7e61-b48b-e33040c6b300', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c578-7e37-80c4-3ba5549c2b28', 'webauthn_credentials_credential_id_key', NULL, NULL, 'u', '{019fbc96-c5d8-7a25-ae9e-cb4b8f8cb654}', false, false, false, 'app', '{}'),
  ('019fbc96-c6fc-7b18-b517-a86edfe4dbaf', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c578-7e37-80c4-3ba5549c2b28', 'webauthn_credentials_webauthn_user_id_owner_id_key', NULL, NULL, 'u', '{019fbc96-c627-7333-8e93-b8b88d0f126e,019fbc96-c5af-7b77-aaa2-499e517505b2}', false, false, false, 'app', '{}'),
  ('019fbc96-c800-760d-b36c-308b06974cce', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c73d-7bb7-945b-3e60ebd7f19a', 'connected_accounts_service_identifier_key', NULL, NULL, 'u', '{019fbc96-c79b-79df-81ef-f9140b62c638,019fbc96-c7b4-77cc-9388-1d56336754e7}', false, false, false, 'app', '{}'),
  ('019fbc96-caa9-7af3-8848-6aa1647d9fb4', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c88d-7ba5-bce4-cfcf39ec99a4', 'identity_providers_slug_key', NULL, NULL, 'u', '{019fbc96-c8cb-775f-9002-6b82491457ca}', false, false, false, 'app', '{}'),
  ('019fbc96-cdc7-7325-bc76-aaead5cb62e3', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cbfa-72b5-bec3-82d33e693371', 'app_invites_invite_token_key', NULL, NULL, 'u', '{019fbc96-cc9e-72c1-86ad-152cc21d2635}', false, false, false, 'app', '{}'),
  ('019fbc96-cdd1-71a7-b525-3940094241cd', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cbfa-72b5-bec3-82d33e693371', 'app_invites_email_sender_id_key', NULL, NULL, 'u', '{019fbc96-cc58-78bc-a672-7794e8640aff,019fbc96-cc7e-7c15-a070-35d6b0863bfe}', false, false, false, 'app', '{}'),
  ('019fbc96-d183-7e76-971e-bce6db91d149', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cf7f-7041-9b02-6402219dc422', 'org_invites_invite_token_key', NULL, NULL, 'u', '{019fbc96-d038-7478-8ebc-88db85ce7b9d}', false, false, false, 'app', '{}'),
  ('019fbc96-d1b3-77ed-bd5b-4d2ea653705b', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cf7f-7041-9b02-6402219dc422', 'org_invites_email_sender_id_entity_id_key', NULL, NULL, 'u', '{019fbc96-cfe0-75c4-ab10-7d422f22a07e,019fbc96-d009-74b1-a64a-e7dc63da8bf3,019fbc96-d18e-7801-ac3d-007fa9736479}', false, false, false, 'app', '{}'),
  ('019fbc96-dba5-762f-8f37-2deceaa29f29', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-dab8-77ea-88cc-6c09b415cd93', 'principal_entities_principal_id_entity_id_key', NULL, NULL, 'u', '{019fbc96-db32-7b8d-8577-7d229462f8d8,019fbc96-db59-70bd-ae24-81df8c516680}', false, false, false, 'app', '{}'),
  ('019fbc96-dd45-77e3-97f8-be0da526403c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-dbf8-7743-a147-16f1aad029b3', 'principal_scope_overrides_principal_id_membership_type_key', NULL, NULL, 'u', '{019fbc96-dc7b-7166-8661-b99cf8aeebe2,019fbc96-dca4-71e8-88bb-394eb92b56db}', false, false, false, 'app', '{}'),
  ('019fbc96-e137-760e-bca3-d6ddbf375120', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-df8c-7b8f-b346-12f61ba2c1ea', 'app_buckets_key_key', NULL, NULL, 'u', '{019fbc96-e00b-780a-83be-82d1732bf3e9}', false, false, false, 'app', '{}'),
  ('019fbc96-e35f-74e0-9b11-66f00519f63b', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-e17f-7451-b63a-298e84a64979', 'app_files_bucket_id_key_key', NULL, NULL, 'u', '{019fbc96-e231-700d-8aa0-e40692cada1d,019fbc96-e1fe-71fb-92bb-28dd6f0ca503}', false, false, false, 'app', '{}');


SET session_replication_role TO DEFAULT;


