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
  ('019fa2a1-5044-7d28-b300-af27c8617077', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'users_username_key', NULL, NULL, 'u', '{019fa2a1-503c-7fc0-a00a-4eb05fdea62f}', false, false, false, 'app', '{}'),
  ('019fa2a1-5077-7c27-a6a7-6862c0f2e064', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5065-75d9-bf4c-86d761848b2b', 'role_types_name_key', NULL, NULL, 'u', '{019fa2a1-5073-71dc-aea3-e4b4fb35ad81}', false, false, false, 'app', '{}'),
  ('019fa2a1-50f8-7022-a323-92d5c63b9754', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50bf-7eba-a17a-9839835e08f4', 'membership_types_name_key', NULL, NULL, 'u', '{019fa2a1-50d7-7bcd-a3c7-27c0840b348c}', false, false, false, 'app', '{}'),
  ('019fa2a1-514e-7a1a-975c-76cb16ef772a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5131-7642-b999-a3637fd3f1a5', 'app_permissions_name_key', NULL, NULL, 'u', '{019fa2a1-5149-7820-a14a-e7bbbfa51243}', false, false, false, 'app', '{}'),
  ('019fa2a1-515b-70c9-8152-6fca90b483a6', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5131-7642-b999-a3637fd3f1a5', 'app_permissions_bitnum_key', NULL, NULL, 'u', '{019fa2a1-5152-7696-944d-043fcc9a22b8}', false, false, false, 'app', '{}'),
  ('019fa2a1-5237-7573-8102-ccd5026a620f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51d7-7525-a82f-f18b7765f445', 'app_limits_name_actor_id_key', NULL, NULL, 'u', '{019fa2a1-51f0-7c3d-9206-e5d57ab8842e,019fa2a1-51f6-7ce7-966e-fce6e342dd38}', false, false, false, 'app', '{}'),
  ('019fa2a1-5269-762b-8df7-05284bbf5adb', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5245-7943-99d6-ab69b0046c4a', 'app_limit_defaults_name_key', NULL, NULL, 'u', '{019fa2a1-5258-7bd6-acae-584f68b08c87}', false, false, false, 'app', '{}'),
  ('019fa2a1-5398-7b04-99df-7b5d8c95ab4b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5378-7160-b636-5d7814a54a7c', 'app_limit_credit_codes_code_key', NULL, NULL, 'u', '{019fa2a1-538d-7780-b253-58a0bb8f8315}', false, false, false, 'app', '{}'),
  ('019fa2a1-5405-7daa-99ca-a4309afbcba0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-53be-7020-a577-17e52f91740f', 'app_limit_credit_code_items_credit_code_id_default_limit_id_key', NULL, NULL, 'u', '{019fa2a1-53d4-74ee-870e-62c728699e0b,019fa2a1-53e0-7c60-96bf-f5f2d990533e}', false, false, false, 'app', '{}'),
  ('019fa2a1-544c-72d3-ac5a-1e44d710b210', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5416-73f2-acac-2d0393ddb8cb', 'app_limit_credit_redemptions_credit_code_id_entity_id_key', NULL, NULL, 'u', '{019fa2a1-542c-73c9-9c1f-d5a723d9b7b6,019fa2a1-5438-791b-975e-0fa20888919b}', false, false, false, 'app', '{}'),
  ('019fa2a1-5492-7c45-97db-06155ed0a239', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5468-7986-ba62-d5ec673318b9', 'app_limit_caps_defaults_name_key', NULL, NULL, 'u', '{019fa2a1-547f-72d1-a766-cad9b117ace8}', false, false, false, 'app', '{}'),
  ('019fa2a1-54c8-7a8f-af65-c687d33f968c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5496-7d14-aea2-866a78236d8a', 'app_limit_caps_name_entity_id_key', NULL, NULL, 'u', '{019fa2a1-54ac-7af7-9af4-30b226829f92,019fa2a1-54b6-705d-aded-16fbc502eec3}', false, false, false, 'app', '{}'),
  ('019fa2a1-5510-7faf-bf55-90809f925a67', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-54d8-72b7-8837-7d5008546c02', 'app_limit_warnings_name_key', NULL, NULL, 'u', '{019fa2a1-54ed-7fb0-91da-ec8f347fcd5d}', false, false, false, 'app', '{}'),
  ('019fa2a1-5552-7bea-ac12-6aecbccd20b4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5515-74cb-b03a-e1a7265372b4', 'app_limit_warning_states_warning_id_actor_id_key', NULL, NULL, 'u', '{019fa2a1-552b-7de4-bda4-523ce4d07a12,019fa2a1-5538-7ee9-a1ba-efe0a9d710ed}', false, false, false, 'app', '{}'),
  ('019fa2a1-56dd-7599-9751-dfc72c402d91', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-558c-7bc2-b6aa-c20fbc1f8f2a', 'app_memberships_actor_id_key', NULL, NULL, 'u', '{019fa2a1-56ce-7ac9-8699-989469cd0e2b}', false, false, false, 'app', '{}'),
  ('019fa2a1-583a-754e-8541-57d10abd68e0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5813-7ca8-bd2f-4f5cde8b71a6', 'app_permission_default_permissions_permission_id_key', NULL, NULL, 'u', '{019fa2a1-582c-7ab0-84fd-d71388aeb4d9}', false, false, false, 'app', '{}'),
  ('019fa2a1-5b60-79cb-9c98-c60659d3a2f8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b1d-7b27-bab2-e3c469e536af', 'user_states_owner_id_name_key', NULL, NULL, 'u', '{019fa2a1-5b3e-7a78-aac7-86fa758c7028,019fa2a1-5b48-7ce2-8042-45022f676c0e}', false, false, false, 'app', '{}'),
  ('019fa2a1-5d6a-7b32-80d1-1f44ac0bc525', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5c8d-7633-a186-023c9c2285e6', 'session_credentials_secret_hash_key', NULL, NULL, 'u', '{019fa2a1-5cca-7b8b-a3f7-255346093ad0}', false, false, false, 'app', '{}'),
  ('019fa2a1-5d70-7526-b5e2-38a49c95652c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5c8d-7633-a186-023c9c2285e6', 'session_credentials_key_id_key', NULL, NULL, 'u', '{019fa2a1-5cc3-7c33-bf85-c06e17612917}', false, false, false, 'app', '{}'),
  ('019fa2a1-5d75-75ab-a353-6754b00904cc', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5c8d-7633-a186-023c9c2285e6', 'session_credentials_ot_token_key', NULL, NULL, 'u', '{019fa2a1-5cfc-7c8e-bb79-e747278d956f}', false, false, false, 'app', '{}'),
  ('019fa2a1-61b8-7d13-bc5d-9a4515419169', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-613c-724f-87a1-acb6049c0b8b', 'session_secrets_session_id_name_key', NULL, NULL, 'u', '{019fa2a1-615c-7be5-9c7c-55a68f7293d7,019fa2a1-6176-7f74-95e2-3f34dfae217a}', false, false, false, 'app', '{}'),
  ('019fa2a1-638a-7eda-8178-ba8e2bee81de', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-62f0-7b99-aea9-87eac6e5fe19', 'auth_ip_rate_limits_ip_address_ua_hash_action_key', NULL, NULL, 'u', '{019fa2a1-6321-7949-a309-b0fd30bbe4bb,019fa2a1-632f-7c8f-ae28-5aa359ed2d1e,019fa2a1-6340-738d-b025-b341742e138c}', false, false, false, 'app', '{}'),
  ('019fa2a1-6424-7877-b0b2-c1cc52c3af63', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-639b-7ad6-b70a-a9e79a494ed0', 'auth_rate_limits_subject_id_action_key', NULL, NULL, 'u', '{019fa2a1-63bc-72ce-97af-d39f4ef35f62,019fa2a1-63cb-74a7-ab20-f5e16fec6ab3}', false, false, false, 'app', '{}'),
  ('019fa2a1-662e-7559-9c42-059a392a7698', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6514-72da-b9d9-3bdb2c772b8c', 'auth_user_devices_user_id_device_token_hash_key', NULL, NULL, 'u', '{019fa2a1-6538-7150-86f3-2139b8fe0b50,019fa2a1-6545-7177-a0e3-422cc4c38b00}', false, false, false, 'app', '{}'),
  ('019fa2a1-66d1-7e8e-8d84-a1c0c2f9418e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6661-7502-b1a4-7ebfccb37ee9', 'user_secrets_owner_id_name_key', NULL, NULL, 'u', '{019fa2a1-6682-737e-a482-bb9985edc949,019fa2a1-668f-7ec9-968d-ec3138a414b1}', false, false, false, 'app', '{}'),
  ('019fa2a1-6a3e-7e5b-8a35-f796f59ca8de', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-69aa-7ba6-a7ef-3303f246936b', 'emails_email_key', NULL, NULL, 'u', '{019fa2a1-69f7-7268-9315-0e1dad55199a}', false, false, false, 'app', '{}'),
  ('019fa2a1-6b55-7aa0-b8d3-b72a7b09f522', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6abc-79b5-a0c3-7f1bb20ebefd', 'phone_numbers_number_key', NULL, NULL, 'u', '{019fa2a1-6b11-7429-b302-5db1d23d732e}', false, false, false, 'app', '{}'),
  ('019fa2a1-6cd5-7384-b792-eb4988105ad1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6bd3-7a50-b4af-3c2cb7aee426', 'webauthn_credentials_credential_id_key', NULL, NULL, 'u', '{019fa2a1-6c15-70b8-b208-d8df76ae8564}', false, false, false, 'app', '{}'),
  ('019fa2a1-6cdb-7b60-a360-d4e33448a3a5', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6bd3-7a50-b4af-3c2cb7aee426', 'webauthn_credentials_webauthn_user_id_owner_id_key', NULL, NULL, 'u', '{019fa2a1-6c4a-7016-aef1-fbe6e284d70c,019fa2a1-6bf8-7cae-be58-da1480a9f718}', false, false, false, 'app', '{}'),
  ('019fa2a1-6d98-7c61-8c08-bd441fd032f0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6d06-750a-9c65-845342800227', 'connected_accounts_service_identifier_key', NULL, NULL, 'u', '{019fa2a1-6d4d-76ee-82a7-7ee857325920,019fa2a1-6d60-7434-a4b6-d23b75dd46b0}', false, false, false, 'app', '{}'),
  ('019fa2a1-6f78-7e1b-85b5-ad77357e87a9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6e03-77a5-8d95-46056bdd7ccf', 'identity_providers_slug_key', NULL, NULL, 'u', '{019fa2a1-6e2b-7af1-9ce3-0b69d171b046}', false, false, false, 'app', '{}'),
  ('019fa2a1-747a-7528-940e-bd6fe1530ff1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-73db-7463-ae1b-141b8847e6ed', 'principal_entities_principal_id_entity_id_key', NULL, NULL, 'u', '{019fa2a1-742d-7938-87d4-d58132ae47f6,019fa2a1-7447-7513-b720-990d24330c95}', false, false, false, 'app', '{}'),
  ('019fa2a1-75aa-76df-adac-8851c0a4a3f6', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-74cf-7e12-bb6b-5a4db46c9efb', 'principal_scope_overrides_principal_id_membership_type_key', NULL, NULL, 'u', '{019fa2a1-7528-7a59-a0b9-40acfa5c648d,019fa2a1-7543-70ce-b2ee-b3abff26e8c4}', false, false, false, 'app', '{}');


SET session_replication_role TO DEFAULT;


