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
  ('019fc104-f31f-7ed7-adfc-ddd5341a7caa', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'users_username_key', NULL, NULL, 'u', '{019fc104-f315-7ce3-9fe4-2862b2c9c1ae}', false, false, false, 'app', '{}'),
  ('019fc104-f35d-702e-9c36-f11bc3a57c81', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f348-71f2-afb5-970509c4ca3e', 'role_types_name_key', NULL, NULL, 'u', '{019fc104-f358-72bc-8aeb-e738a2d78da1}', false, false, false, 'app', '{}'),
  ('019fc104-f3ec-79f0-beae-bba4d21b6e6f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f3b3-7db4-9f2a-97645203d652', 'membership_types_name_key', NULL, NULL, 'u', '{019fc104-f3cd-70de-a6e4-526f3c40672b}', false, false, false, 'app', '{}'),
  ('019fc104-f44a-72ec-aa4e-a8a312d30757', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f42b-7451-ad34-360101e6f0bb', 'app_permissions_name_key', NULL, NULL, 'u', '{019fc104-f444-742f-b294-b570842248a1}', false, false, false, 'app', '{}'),
  ('019fc104-f457-7bd9-a40b-4d02fc7a4e57', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f42b-7451-ad34-360101e6f0bb', 'app_permissions_bitnum_key', NULL, NULL, 'u', '{019fc104-f44e-7273-837b-4fd5835d16bb}', false, false, false, 'app', '{}'),
  ('019fc104-f543-77aa-822a-60afec0bb682', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4e1-7642-9736-e6d5dfaceeac', 'app_limits_name_actor_id_key', NULL, NULL, 'u', '{019fc104-f4fd-7584-ba64-1e2034365648,019fc104-f503-75a1-97a1-e45b646df2f6}', false, false, false, 'app', '{}'),
  ('019fc104-f578-70e6-8252-4e49328cfa62', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f551-7c69-b70e-4ba81d6e04f1', 'app_limit_defaults_name_key', NULL, NULL, 'u', '{019fc104-f566-75f3-b1ba-8b3d0903b635}', false, false, false, 'app', '{}'),
  ('019fc104-f6c1-7818-8fcb-afacac2b2218', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f69f-7fbe-a15f-ad7b4e36cce1', 'app_limit_credit_codes_code_key', NULL, NULL, 'u', '{019fc104-f6b8-70e7-9502-d6dbd6162876}', false, false, false, 'app', '{}'),
  ('019fc104-f735-7fe7-a144-c267a34d78a4', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f6e8-7711-ab24-10ebe24dbe7f', 'app_limit_credit_code_items_credit_code_id_default_limit_id_key', NULL, NULL, 'u', '{019fc104-f702-7085-890f-78212c3b8b4f,019fc104-f70f-73f4-b36d-4a7e6ce74b36}', false, false, false, 'app', '{}'),
  ('019fc104-f783-7847-99d1-0f4f23a49d0f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f748-73ab-8b1b-1b6201c67237', 'app_limit_credit_redemptions_credit_code_id_entity_id_key', NULL, NULL, 'u', '{019fc104-f761-7515-91fe-1bb38308d1b4,019fc104-f76e-7760-bbce-f560b76bf12a}', false, false, false, 'app', '{}'),
  ('019fc104-f7c6-7661-b76d-da6536a06318', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f798-7c31-b507-71cb546e48e8', 'app_limit_caps_defaults_name_key', NULL, NULL, 'u', '{019fc104-f7b1-7346-b8d1-70652ddae730}', false, false, false, 'app', '{}'),
  ('019fc104-f801-7b9a-8cd4-5e5ad9b0ebf4', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f7cb-724e-9322-353d4f589b28', 'app_limit_caps_name_entity_id_key', NULL, NULL, 'u', '{019fc104-f7e3-74c3-95ce-7c1d7392fa73,019fc104-f7ed-7b8c-80fd-5b56c02dcdf6}', false, false, false, 'app', '{}'),
  ('019fc104-f851-79a5-ae7f-9f043d54e7fa', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f812-7521-9ae3-ca04fb0dcced', 'app_limit_warnings_name_key', NULL, NULL, 'u', '{019fc104-f82b-7925-9e6d-408baab8f92f}', false, false, false, 'app', '{}'),
  ('019fc104-f899-7553-a345-453e0e3bf75d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f856-7ccd-9517-b0ea87623895', 'app_limit_warning_states_warning_id_actor_id_key', NULL, NULL, 'u', '{019fc104-f870-7e74-b7ba-f7248112ff3b,019fc104-f87e-7692-aea7-adc8cd2ec2ba}', false, false, false, 'app', '{}'),
  ('019fc104-fa37-71a4-bb9c-8ea9ad281b24', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8d1-7179-8d86-1ce7702d0104', 'app_memberships_actor_id_key', NULL, NULL, 'u', '{019fc104-fa28-743c-a02f-1601b02766db}', false, false, false, 'app', '{}'),
  ('019fc104-fb94-79d1-a128-ba80a94f2dd3', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb69-7e31-ba8b-e7e1377de333', 'app_permission_default_permissions_permission_id_key', NULL, NULL, 'u', '{019fc104-fb83-7fc8-b958-d0f935542104}', false, false, false, 'app', '{}'),
  ('019fc104-feaf-798f-8cb2-94d05c48801b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe6f-719a-8b3f-c157587194b5', 'user_states_owner_id_name_key', NULL, NULL, 'u', '{019fc104-fe8d-7908-b58d-fdfc1df77a47,019fc104-fe97-7664-aa87-8f905126f824}', false, false, false, 'app', '{}'),
  ('019fc105-00ac-742b-bbd5-322e80c0951d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-ffd2-7869-bc0e-15e9e9f99044', 'session_credentials_secret_hash_key', NULL, NULL, 'u', '{019fc105-0011-78f1-bf2d-ae600cfbdd2e}', false, false, false, 'app', '{}'),
  ('019fc105-00b2-746d-b5ab-14f13a153838', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-ffd2-7869-bc0e-15e9e9f99044', 'session_credentials_key_id_key', NULL, NULL, 'u', '{019fc105-000a-7520-98cb-d53926221d0d}', false, false, false, 'app', '{}'),
  ('019fc105-00b7-7524-8c50-380538bfd4ef', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-ffd2-7869-bc0e-15e9e9f99044', 'session_credentials_ot_token_key', NULL, NULL, 'u', '{019fc105-0069-708f-b529-36a9d379fd5b}', false, false, false, 'app', '{}'),
  ('019fc105-04ea-7db8-960f-9df907390d45', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0471-784c-9f94-cb05526be1f0', 'session_secrets_session_id_name_key', NULL, NULL, 'u', '{019fc105-0492-78a1-8d83-91add7441eca,019fc105-04ac-777e-8bf3-b78038f49d45}', false, false, false, 'app', '{}'),
  ('019fc105-06a9-7b95-b9ee-d5c9940e900a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0611-7e5d-8c39-47e53c2a80d2', 'auth_ip_rate_limits_ip_address_ua_hash_action_key', NULL, NULL, 'u', '{019fc105-0633-736a-853d-c04d7a32fd7d,019fc105-0641-74e9-a812-0bd3f32f1f2f,019fc105-0651-781a-bb19-af692fafc66a}', false, false, false, 'app', '{}'),
  ('019fc105-074c-76c6-99ee-211f6da8c358', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-06bc-74e6-9286-763950a36e86', 'auth_rate_limits_subject_id_action_key', NULL, NULL, 'u', '{019fc105-06df-78d9-9483-143575786201,019fc105-06ed-7648-a7bd-8982a1c6c92e}', false, false, false, 'app', '{}'),
  ('019fc105-095e-7827-8758-5467bd39f81b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0837-7cb1-9c78-199827e949c6', 'auth_user_devices_user_id_device_token_hash_key', NULL, NULL, 'u', '{019fc105-085b-75cc-a095-c1e20639fec2,019fc105-0869-7f53-91ed-ac2262cf8c32}', false, false, false, 'app', '{}'),
  ('019fc105-0a0b-7d8b-a5eb-da4df5960930', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0996-7bb7-8ecb-595462857b72', 'user_secrets_owner_id_name_key', NULL, NULL, 'u', '{019fc105-09b7-745e-adaf-3c7e0e04f279,019fc105-09c4-7e53-aa7b-a1e6817ef4c5}', false, false, false, 'app', '{}'),
  ('019fc105-0d92-71b6-bd78-b6496a94893e', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cf6-7075-9d35-6b418c5f8913', 'emails_email_key', NULL, NULL, 'u', '{019fc105-0d44-7e33-a65c-169f0f57f400}', false, false, false, 'app', '{}'),
  ('019fc105-0eab-7ff4-9956-0ab038f7fa4b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0e13-7f38-9a06-598fb71d8c7b', 'phone_numbers_number_key', NULL, NULL, 'u', '{019fc105-0e6a-787c-830e-817764099b72}', false, false, false, 'app', '{}'),
  ('019fc105-1036-745f-b81f-36e34dea8e71', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0f2e-795d-b36f-44859808a931', 'webauthn_credentials_credential_id_key', NULL, NULL, 'u', '{019fc105-0f73-74b1-b6bd-4e0d0bda18cd}', false, false, false, 'app', '{}'),
  ('019fc105-103d-76e2-b4b7-2acbae667d03', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0f2e-795d-b36f-44859808a931', 'webauthn_credentials_webauthn_user_id_owner_id_key', NULL, NULL, 'u', '{019fc105-0fa9-7ff2-acd0-144e42db669b,019fc105-0f56-74a7-98eb-fb4884d24331}', false, false, false, 'app', '{}'),
  ('019fc105-10ff-7db9-af9f-747339831406', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-106d-7a9f-9f9f-9b50b89450ca', 'connected_accounts_service_identifier_key', NULL, NULL, 'u', '{019fc105-10b5-786c-b1f2-72deeb1eddfc,019fc105-10c8-7be6-9ce7-e80e6fde29e6}', false, false, false, 'app', '{}'),
  ('019fc105-12fa-78c8-a969-218a0f19adf2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1171-72ca-849a-5ad7ac0b2fd3', 'identity_providers_slug_key', NULL, NULL, 'u', '{019fc105-119b-7373-861d-99bc15cf98fc}', false, false, false, 'app', '{}'),
  ('019fc105-198f-7828-9ba8-288c8967443d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-18e2-7443-87f5-499f34c69054', 'principal_entities_principal_id_entity_id_key', NULL, NULL, 'u', '{019fc105-193a-7dcf-b04b-944456f3fcfc,019fc105-1958-736a-a089-bbf4a4c492a0}', false, false, false, 'app', '{}'),
  ('019fc105-1aad-7639-844e-b18fe88734a0', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-19cc-790a-b75f-2797f5dd0ac3', 'principal_scope_overrides_principal_id_membership_type_key', NULL, NULL, 'u', '{019fc105-1a25-728f-8eaf-e99a02fd9dac,019fc105-1a40-7109-a3bd-38d43db6a596}', false, false, false, 'app', '{}');


SET session_replication_role TO DEFAULT;


