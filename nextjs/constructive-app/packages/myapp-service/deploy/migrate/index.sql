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
  ('019fa2a1-5060-7f71-a59c-72c82ff916d8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'users_search_tsv_gin_idx', '{019fa2a1-5053-737a-bf40-59ea3ee68b83}', '{}', 'GIN', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-5085-7042-bd69-32110c0901d8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'users_type_idx', '{019fa2a1-507a-7958-a296-28528bcf1ff5}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-5202-7650-a9b6-75c217c129fc', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51d7-7525-a82f-f18b7765f445', 'app_limits_actor_id_idx', '{019fa2a1-51f6-7ce7-966e-fce6e342dd38}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-52a2-7f1f-8273-82bcc36751bd', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5285-725c-9bcd-65d477e277f4', 'app_limit_credits_default_limit_id_idx', '{019fa2a1-5298-728b-b7fb-74c9a5b6a767}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-52af-729a-9a02-cfbcae204bbf', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5285-725c-9bcd-65d477e277f4', 'app_limit_credits_actor_id_idx', '{019fa2a1-52a6-7390-85ec-85f4ebdfe15f}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-53ed-7997-8a48-7209eec50daa', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-53be-7020-a577-17e52f91740f', 'app_limit_credit_code_items_default_limit_id_idx', '{019fa2a1-53e0-7c60-96bf-f5f2d990533e}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-5547-7084-8fea-ab883d1bf864', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5515-74cb-b03a-e1a7265372b4', 'app_limit_warning_states_actor_id_idx', '{019fa2a1-5538-7ee9-a1ba-efe0a9d710ed}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-563f-7a3f-9883-0a3733a61dc9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5607-704a-bacc-b1c2d99357f7', 'app_memberships_sprts_actor_id_idx', '{019fa2a1-5636-7eb0-bf8e-47d30e4ed394}', '{019fa2a1-5629-7851-a746-aa7930e414c9,019fa2a1-5611-7171-b366-3ffd3acf8ea0,019fa2a1-561c-769f-a660-ae5fa29d2da1}', 'BTREE', NULL, NULL, true, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-5727-78fa-b93d-646eca0e9749', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-56f9-78f0-931f-4812580b70dd', 'app_admin_grants_actor_id_idx', '{019fa2a1-571d-75ba-aaf3-4bdfa60b4dfa}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-5736-7e97-ad18-29d211a8a4f4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-56f9-78f0-931f-4812580b70dd', 'app_admin_grants_grantor_id_idx', '{019fa2a1-572b-7a47-99e3-3273d37f64af}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-5783-766c-9cf7-455c3b8ff926', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-574e-737f-9b1f-25f5eb8d9dd6', 'app_owner_grants_actor_id_idx', '{019fa2a1-5778-7169-8f23-c2a2d299410e}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-5793-72d8-b23f-97d62297d22d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-574e-737f-9b1f-25f5eb8d9dd6', 'app_owner_grants_grantor_id_idx', '{019fa2a1-5787-799d-8e33-bfb6ad8c9050}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-57ea-7c6e-87c1-ebe2d7f15c0b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-57ac-73c9-bd3e-65e6d7444548', 'app_grants_actor_id_idx', '{019fa2a1-57df-7bdc-9721-441953288aa0}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-57fa-768d-b6ac-a9b4699c9477', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-57ac-73c9-bd3e-65e6d7444548', 'app_grants_grantor_id_idx', '{019fa2a1-57ee-7bc2-853f-f2b4f1fd1ff1}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-5888-78a0-9e87-7a660c151633', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5856-7452-ad3a-45b1f4c4fc67', 'app_permission_default_grants_permission_id_idx', '{019fa2a1-5876-7f69-bb81-16b11c88f35a}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-58ab-7970-9a50-4eaa2ab9469c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5856-7452-ad3a-45b1f4c4fc67', 'app_permission_default_grants_grantor_id_idx', '{019fa2a1-589d-7a89-b89f-afbd333791bf}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-5c88-7bd5-8538-5cd69694b802', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5bbc-7d2a-a42f-af8235516fb4', 'sessions_user_id_idx', '{019fa2a1-5be6-73b8-abcc-78736fe30d22}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-5d7a-76bd-aa34-2dd30eda8599', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5c8d-7633-a186-023c9c2285e6', 'session_credentials_session_id_idx', '{019fa2a1-5caa-7463-bbc7-4a047f44c418}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-5d7f-74df-908f-0904b4197c6c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5c8d-7633-a186-023c9c2285e6', 'session_credentials_kind_idx', '{019fa2a1-5cb5-705e-bd38-6a807e6b02d2}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-6171-733d-810f-19571ef1389a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-613c-724f-87a1-acb6049c0b8b', 'session_secrets_session_id_idx', '{019fa2a1-615c-7be5-9c7c-55a68f7293d7}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-6391-7b23-aeb8-64783a9b0f28', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-62f0-7b99-aea9-87eac6e5fe19', 'auth_ip_rate_limits_ip_address_idx', '{019fa2a1-6321-7949-a309-b0fd30bbe4bb}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-6396-7cb5-ada1-521d5c782aa3', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-62f0-7b99-aea9-87eac6e5fe19', 'auth_ip_rate_limits_locked_until_idx', '{019fa2a1-6366-77a6-87e7-7955de7fa306}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-642a-774d-a926-e72f2d228e76', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-639b-7ad6-b70a-a9e79a494ed0', 'auth_rate_limits_subject_id_idx', '{019fa2a1-63bc-72ce-97af-d39f4ef35f62}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-6432-75d6-800d-fbad6c3344f8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-639b-7ad6-b70a-a9e79a494ed0', 'auth_rate_limits_locked_until_idx', '{019fa2a1-6400-79d0-aa72-b30fbd7563b4}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-6634-75c5-93fb-ec85049bb279', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6514-72da-b9d9-3bdb2c772b8c', 'auth_user_devices_user_id_idx', '{019fa2a1-6538-7150-86f3-2139b8fe0b50}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-6639-73d1-a1fc-e1c4052c530b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6514-72da-b9d9-3bdb2c772b8c', 'auth_user_devices_device_token_hash_idx', '{019fa2a1-6545-7177-a0e3-422cc4c38b00}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-663e-7271-bf51-4d660a401abf', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6514-72da-b9d9-3bdb2c772b8c', 'auth_user_devices_trust_expires_at_idx', '{019fa2a1-65ef-7949-95a8-8c8a4a2977a0}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-69f1-71b6-a198-82160bfff035', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-69aa-7ba6-a7ef-3303f246936b', 'emails_owner_id_idx', '{019fa2a1-69d7-7270-8c78-7fb7cca55665}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-6af9-7957-9474-89c6152d9f6c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6abc-79b5-a0c3-7f1bb20ebefd', 'phone_numbers_owner_id_idx', '{019fa2a1-6ae2-75a2-a49d-608b8c75952b}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-6c0f-7519-967b-2ccdff60c031', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6bd3-7a50-b4af-3c2cb7aee426', 'webauthn_credentials_owner_id_idx', '{019fa2a1-6bf8-7cae-be58-da1480a9f718}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-6d47-7d06-8ffa-b02fcb23730f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6d06-750a-9c65-845342800227', 'connected_accounts_owner_id_idx', '{019fa2a1-6d2f-7e5d-9af5-aece0df2fa96}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-70c3-7024-946e-ce501370b59a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-703c-73a4-bcd4-ef0ed194b005', 'audit_log_auths_event_idx', '{019fa2a1-706b-7f0c-9d7f-2c9b55783536}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-70d2-71f4-b977-141c987125c9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-703c-73a4-bcd4-ef0ed194b005', 'audit_log_auths_actor_id_idx', '{019fa2a1-707d-7ce6-b139-7d0b06a73674}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-73ce-7cb1-9d80-08b4361ac5c2', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-72e9-73af-9d7e-46dedcbda5ad', 'principals_owner_id_idx', '{019fa2a1-733c-7182-b1f2-30ca923f535f}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-73d5-728c-95ea-aed820c9eb7e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-72e9-73af-9d7e-46dedcbda5ad', 'principals_user_id_idx', '{019fa2a1-7355-7a52-a7b4-0631f0375585}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-7481-7f14-9555-294f684edd8a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-73db-7463-ae1b-141b8847e6ed', 'principal_entities_principal_id_idx', '{019fa2a1-742d-7938-87d4-d58132ae47f6}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-7487-7c0c-9b55-eed490dd17a0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-73db-7463-ae1b-141b8847e6ed', 'principal_entities_entity_id_idx', '{019fa2a1-7447-7513-b720-990d24330c95}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-748d-7f6b-afe7-a813d91b2da7', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-73db-7463-ae1b-141b8847e6ed', 'principal_entities_owner_id_idx', '{019fa2a1-7461-74ce-bd73-c60921c1de9d}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}'),
  ('019fa2a1-75b1-7eaa-95a6-3ab3934f9602', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-74cf-7e12-bb6b-5a4db46c9efb', 'principal_scope_overrides_principal_id_idx', '{019fa2a1-7528-7a59-a0b9-40acfa5c648d}', '{}', 'BTREE', NULL, NULL, false, NULL, '{}', NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


