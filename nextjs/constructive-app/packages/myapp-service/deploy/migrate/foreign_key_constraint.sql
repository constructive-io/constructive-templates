-- Deploy: migrate/foreign_key_constraint
-- made with <3 @ constructive.io

-- requires: migrate/field


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

INSERT INTO metaschema_public.foreign_key_constraint (
  id,
  database_id,
  table_id,
  name,
  description,
  smart_tags,
  type,
  field_ids,
  ref_table_id,
  ref_field_ids,
  delete_action,
  update_action,
  with_period,
  delete_set_field_ids,
  is_deferrable,
  initially_deferred,
  category,
  tags
) VALUES
  ('019fa2a1-5080-7af4-bb92-31f6f40e2bdc', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'users_type_fkey', NULL, NULL, 'f', '{019fa2a1-507a-7958-a296-28528bcf1ff5}', '019fa2a1-5065-75d9-bf4c-86d761848b2b', '{019fa2a1-506c-7291-b12a-e11f3e42ae1d}', 'r', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-51fd-77b3-9552-a0ca2589e968', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51d7-7525-a82f-f18b7765f445', 'app_limits_actor_id_fkey', NULL, NULL, 'f', '{019fa2a1-51f6-7ce7-966e-fce6e342dd38}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-529e-7faa-b501-87e8e161a3c1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5285-725c-9bcd-65d477e277f4', 'app_limit_credits_default_limit_id_fkey', NULL, NULL, 'f', '{019fa2a1-5298-728b-b7fb-74c9a5b6a767}', '019fa2a1-5245-7943-99d6-ab69b0046c4a', '{019fa2a1-524e-706e-a931-faa298ea6d53}', 'r', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-52ab-7183-9508-336ca0752601', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5285-725c-9bcd-65d477e277f4', 'app_limit_credits_actor_id_fkey', NULL, NULL, 'f', '{019fa2a1-52a6-7390-85ec-85f4ebdfe15f}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-53dc-7202-856f-39634b549f4f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-53be-7020-a577-17e52f91740f', 'app_limit_credit_code_items_credit_code_id_fkey', NULL, NULL, 'f', '{019fa2a1-53d4-74ee-870e-62c728699e0b}', '019fa2a1-5378-7160-b636-5d7814a54a7c', '{019fa2a1-5381-76aa-932e-6fa64e3e2c36}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-53e8-7ef9-86d7-3c4908130d73', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-53be-7020-a577-17e52f91740f', 'app_limit_credit_code_items_default_limit_id_fkey', NULL, NULL, 'f', '{019fa2a1-53e0-7c60-96bf-f5f2d990533e}', '019fa2a1-5245-7943-99d6-ab69b0046c4a', '{019fa2a1-524e-706e-a931-faa298ea6d53}', 'r', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-5434-7210-93e6-7b688760c316', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5416-73f2-acac-2d0393ddb8cb', 'app_limit_credit_redemptions_credit_code_id_fkey', NULL, NULL, 'f', '{019fa2a1-542c-73c9-9c1f-d5a723d9b7b6}', '019fa2a1-5378-7160-b636-5d7814a54a7c', '{019fa2a1-5381-76aa-932e-6fa64e3e2c36}', 'r', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-5534-7729-a40f-c284e236b65a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5515-74cb-b03a-e1a7265372b4', 'app_limit_warning_states_warning_id_fkey', NULL, NULL, 'f', '{019fa2a1-552b-7de4-bda4-523ce4d07a12}', '019fa2a1-54d8-72b7-8837-7d5008546c02', '{019fa2a1-54e1-7455-b71d-a13074b45965}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-5542-7703-8b3e-edadf5267506', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5515-74cb-b03a-e1a7265372b4', 'app_limit_warning_states_actor_id_fkey', NULL, NULL, 'f', '{019fa2a1-5538-7ee9-a1ba-efe0a9d710ed}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-56d7-7e4e-9fe8-f15b414d0d00', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-558c-7bc2-b6aa-c20fbc1f8f2a', 'app_memberships_actor_id_fkey', NULL, NULL, 'f', '{019fa2a1-56ce-7ac9-8699-989469cd0e2b}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-5723-7050-818c-9cf1d4c20710', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-56f9-78f0-931f-4812580b70dd', 'app_admin_grants_actor_id_fkey', NULL, NULL, 'f', '{019fa2a1-571d-75ba-aaf3-4bdfa60b4dfa}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-5732-767b-9dff-176b5dd08ec6', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-56f9-78f0-931f-4812580b70dd', 'app_admin_grants_grantor_id_fkey', NULL, NULL, 'f', '{019fa2a1-572b-7a47-99e3-3273d37f64af}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-577e-77ea-9676-58467f630d28', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-574e-737f-9b1f-25f5eb8d9dd6', 'app_owner_grants_actor_id_fkey', NULL, NULL, 'f', '{019fa2a1-5778-7169-8f23-c2a2d299410e}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-578e-756d-934d-c38dacef6f2c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-574e-737f-9b1f-25f5eb8d9dd6', 'app_owner_grants_grantor_id_fkey', NULL, NULL, 'f', '{019fa2a1-5787-799d-8e33-bfb6ad8c9050}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-57e5-7d8f-8528-def9c6364bcb', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-57ac-73c9-bd3e-65e6d7444548', 'app_grants_actor_id_fkey', NULL, NULL, 'f', '{019fa2a1-57df-7bdc-9721-441953288aa0}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-57f5-787a-983c-61a5670c905c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-57ac-73c9-bd3e-65e6d7444548', 'app_grants_grantor_id_fkey', NULL, NULL, 'f', '{019fa2a1-57ee-7bc2-853f-f2b4f1fd1ff1}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-5835-77a9-a58a-459a3d04a7f8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5813-7ca8-bd2f-4f5cde8b71a6', 'app_permission_default_permissions_permission_id_fkey', NULL, NULL, 'f', '{019fa2a1-582c-7ab0-84fd-d71388aeb4d9}', '019fa2a1-5131-7642-b999-a3637fd3f1a5', '{019fa2a1-513c-79cb-992b-327417b4c764}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-5882-7b04-869a-a826e5fc4056', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5856-7452-ad3a-45b1f4c4fc67', 'app_permission_default_grants_permission_id_fkey', NULL, NULL, 'f', '{019fa2a1-5876-7f69-bb81-16b11c88f35a}', '019fa2a1-5131-7642-b999-a3637fd3f1a5', '{019fa2a1-513c-79cb-992b-327417b4c764}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-58a6-700f-a181-2a922c33138e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5856-7452-ad3a-45b1f4c4fc67', 'app_permission_default_grants_grantor_id_fkey', NULL, NULL, 'f', '{019fa2a1-589d-7a89-b89f-afbd333791bf}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-6169-7b7b-bc6c-4f69cb26b365', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-613c-724f-87a1-acb6049c0b8b', 'session_secrets_session_id_fkey', NULL, NULL, 'f', '{019fa2a1-615c-7be5-9c7c-55a68f7293d7}', '019fa2a1-5bbc-7d2a-a42f-af8235516fb4', '{019fa2a1-5bcf-7262-b8a0-6298c7d42865}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-6628-7421-8be3-a04af6a4335d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6514-72da-b9d9-3bdb2c772b8c', 'auth_user_devices_user_id_fkey', NULL, NULL, 'f', '{019fa2a1-6538-7150-86f3-2139b8fe0b50}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-69e8-7e82-b983-231b39a523f1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-69aa-7ba6-a7ef-3303f246936b', 'emails_owner_id_fkey', NULL, NULL, 'f', '{019fa2a1-69d7-7270-8c78-7fb7cca55665}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-6af2-7b18-a60b-d7a1307ad9af', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6abc-79b5-a0c3-7f1bb20ebefd', 'phone_numbers_owner_id_fkey', NULL, NULL, 'f', '{019fa2a1-6ae2-75a2-a49d-608b8c75952b}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-6c08-7123-9602-867965b8113f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6bd3-7a50-b4af-3c2cb7aee426', 'webauthn_credentials_owner_id_fkey', NULL, NULL, 'f', '{019fa2a1-6bf8-7cae-be58-da1480a9f718}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-6d41-737b-9817-792d6c2152d5', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6d06-750a-9c65-845342800227', 'connected_accounts_owner_id_fkey', NULL, NULL, 'f', '{019fa2a1-6d2f-7e5d-9af5-aece0df2fa96}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-70c9-7ef9-ba13-3b71b2d7afa8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-703c-73a4-bcd4-ef0ed194b005', 'audit_log_auths_actor_id_fkey', NULL, NULL, 'f', '{019fa2a1-707d-7ce6-b139-7d0b06a73674}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-734e-71cd-9ff0-307e0e0a24b0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-72e9-73af-9d7e-46dedcbda5ad', 'principals_owner_id_fkey', NULL, NULL, 'f', '{019fa2a1-733c-7182-b1f2-30ca923f535f}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-7367-7ea5-813f-eb05a478a972', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-72e9-73af-9d7e-46dedcbda5ad', 'principals_user_id_fkey', NULL, NULL, 'f', '{019fa2a1-7355-7a52-a7b4-0631f0375585}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-743f-775e-95e6-422a554f74a2', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-73db-7463-ae1b-141b8847e6ed', 'principal_entities_principal_id_fkey', NULL, NULL, 'f', '{019fa2a1-742d-7938-87d4-d58132ae47f6}', '019fa2a1-72e9-73af-9d7e-46dedcbda5ad', '{019fa2a1-72fc-72ce-8dd6-c31176eca390}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-7459-7e43-97b7-282c9596cdb3', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-73db-7463-ae1b-141b8847e6ed', 'principal_entities_entity_id_fkey', NULL, NULL, 'f', '{019fa2a1-7447-7513-b720-990d24330c95}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-7472-7d46-bed2-ed627fb9ca3a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-73db-7463-ae1b-141b8847e6ed', 'principal_entities_owner_id_fkey', NULL, NULL, 'f', '{019fa2a1-7461-74ce-bd73-c60921c1de9d}', '019fa2a1-5022-77c8-9de2-2ef6079855de', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fa2a1-753a-76ba-97f2-b5bc56fce8cc', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-74cf-7e12-bb6b-5a4db46c9efb', 'principal_scope_overrides_principal_id_fkey', NULL, NULL, 'f', '{019fa2a1-7528-7a59-a0b9-40acfa5c648d}', '019fa2a1-72e9-73af-9d7e-46dedcbda5ad', '{019fa2a1-72fc-72ce-8dd6-c31176eca390}', 'c', 'a', false, '{}', false, false, 'app', '{}');


SET session_replication_role TO DEFAULT;


