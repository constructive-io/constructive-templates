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
  ('019feb75-78fb-7001-b6f0-24add1761ee4', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78e2-720e-82dc-c3ed84264ce8', 'users_username_key', NULL, NULL, 'u', '{019feb75-78f6-7075-a739-65eaadd1baa3}', false, false, false, 'app', '{}'),
  ('019feb75-791a-7b11-a8c6-a79a3f31a1fc', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7911-7db8-a88d-ce102149bb22', 'role_types_name_key', NULL, NULL, 'u', '{019feb75-7918-784a-8058-6527bc344545}', false, false, false, 'app', '{}'),
  ('019feb75-7955-7c3f-b4eb-b9ae47aa4933', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7940-7758-b3b9-f53e917bff10', 'membership_types_name_key', NULL, NULL, 'u', '{019feb75-794d-7041-bf5b-ba7741420267}', false, false, false, 'app', '{}'),
  ('019feb75-798a-74d1-9dec-7ad32de7321b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-797b-7fe2-bec7-40f720b33f6b', 'app_capabilities_name_key', NULL, NULL, 'u', '{019feb75-7987-7f5b-99bf-acada0cac121}', false, false, false, 'app', '{}'),
  ('019feb75-798e-7fd4-9251-2dfe78c57d80', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-797b-7fe2-bec7-40f720b33f6b', 'app_capabilities_bitnum_key', NULL, NULL, 'u', '{019feb75-798b-7de5-a1d5-684c9bce7b7c}', false, false, false, 'app', '{}'),
  ('019feb75-79e9-76a5-b8be-194ee09d2fe5', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79c8-7b1d-97d4-30cd885258c7', 'app_limits_name_actor_id_key', NULL, NULL, 'u', '{019feb75-79d6-7099-84cb-a72ddffcdb19,019feb75-79d8-79bb-925c-ae6ce0fc15f4}', false, false, false, 'app', '{}'),
  ('019feb75-79fb-7c68-be37-d1c1ae0a9d1b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79ee-72c1-a134-d898911d2b82', 'app_limit_defaults_name_key', NULL, NULL, 'u', '{019feb75-79f6-75cf-a98c-4041831199fe}', false, false, false, 'app', '{}'),
  ('019feb75-7ab0-7786-a1ff-b2cfaa8f0b0b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7aa4-7b5b-aacc-2517f0ff61eb', 'app_limit_credit_codes_code_key', NULL, NULL, 'u', '{019feb75-7aad-766d-890f-724bbd4feca9}', false, false, false, 'app', '{}'),
  ('019feb75-7ad2-7929-b983-426d928ef481', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7aba-7a92-9d13-8877944a965f', 'app_limit_credit_code_items_credit_code_id_default_limit_id_key', NULL, NULL, 'u', '{019feb75-7ac2-7d82-aeea-1ff00f482138,019feb75-7ac6-7e54-b25f-647399ee44fe}', false, false, false, 'app', '{}'),
  ('019feb75-7aeb-7f31-87cf-ae513598234a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ad8-7045-8b15-a07b2abdb858', 'app_limit_credit_redemptions_credit_code_id_entity_id_key', NULL, NULL, 'u', '{019feb75-7ae0-7ab2-bc1d-4433cc808111,019feb75-7ae5-75a4-908f-b0cb8021c974}', false, false, false, 'app', '{}'),
  ('019feb75-7b06-7d8a-8ffd-3f9e62facd87', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7af8-783b-b7e9-73b66653c4a4', 'app_limit_caps_defaults_name_key', NULL, NULL, 'u', '{019feb75-7b01-77e6-86d3-cec6436e3988}', false, false, false, 'app', '{}'),
  ('019feb75-7b18-7124-9f48-17fa629ae4ba', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b08-7ddd-a465-1505c8a5e604', 'app_limit_caps_name_entity_id_key', NULL, NULL, 'u', '{019feb75-7b11-719e-8acb-45a09bdae832,019feb75-7b14-73c2-aef1-1ae40ead23f6}', false, false, false, 'app', '{}'),
  ('019feb75-7b37-7b51-b179-7ff8967c553f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b26-7496-8f57-9d3af1da9a94', 'app_limit_warnings_name_key', NULL, NULL, 'u', '{019feb75-7b2e-7ba2-b5ba-0cddcc89b502}', false, false, false, 'app', '{}'),
  ('019feb75-7b4e-7416-a8b5-1b1e0c8b8bb1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b39-7dcd-a575-3a0ef02c3a5b', 'app_limit_warning_states_warning_id_actor_id_key', NULL, NULL, 'u', '{019feb75-7b42-7748-838e-64f77adad701,019feb75-7b46-7727-a5e0-6d4aeb99d712}', false, false, false, 'app', '{}'),
  ('019feb75-7bd8-7924-972a-10ab956575b9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b6d-72f4-9506-d4f1cf2023b7', 'app_memberships_actor_id_key', NULL, NULL, 'u', '{019feb75-7bd3-7a55-8d2f-39078686764f}', false, false, false, 'app', '{}'),
  ('019feb75-7c55-7cdf-a097-0d9e278ae65f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7c4a-7e32-9627-f808c8005aec', 'app_capability_default_capabilities_capability_id_key', NULL, NULL, 'u', '{019feb75-7c52-709a-90b3-eb54319f0e89}', false, false, false, 'app', '{}'),
  ('019feb75-7ce1-7253-ab77-5ffd013f28f0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cbc-7f64-80c7-6d62d91becf3', 'app_profiles_name_key', NULL, NULL, 'u', '{019feb75-7ccb-72af-8d18-d936f25d7ef2}', false, false, false, 'app', '{}'),
  ('019feb75-7ce3-7a7c-938c-b60885413220', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cbc-7f64-80c7-6d62d91becf3', 'app_profiles_slug_key', NULL, NULL, 'u', '{019feb75-7cce-7b05-b2a7-28d674203fa9}', false, false, false, 'app', '{}'),
  ('019feb75-7cfc-7b83-b9fc-7e7e0be1b799', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cea-7eb1-916e-f55daf9eb5a8', 'app_profile_capabilities_profile_id_capability_id_key', NULL, NULL, 'u', '{019feb75-7cf2-7d4b-981a-3794906b7f2e,019feb75-7cf7-72a7-a4eb-ef7d88dc28c3}', false, false, false, 'app', '{}'),
  ('019feb75-7d67-7784-a27d-d809a70b6dee', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7d53-712f-8ea5-88ad311bf62b', 'app_membership_profiles_membership_id_profile_id_key', NULL, NULL, 'u', '{019feb75-7d5b-7370-8e66-6e937c9f9c24,019feb75-7d5f-7322-bbf0-56d7511452af}', false, false, false, 'app', '{}'),
  ('019feb75-7dba-760a-8eda-6833b7efb8f4', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7d9f-7c4a-8d87-de64c404c98f', 'app_profile_templates_name_key', NULL, NULL, 'u', '{019feb75-7da8-7ae1-81af-a305fdffcd8f}', false, false, false, 'app', '{}'),
  ('019feb75-7dbc-77cd-a8d5-ca61c17b543e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7d9f-7c4a-8d87-de64c404c98f', 'app_profile_templates_slug_key', NULL, NULL, 'u', '{019feb75-7dac-7247-8cb6-349b0e0d81a7}', false, false, false, 'app', '{}'),
  ('019feb75-7eed-759c-8d68-20e9c1a48212', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ee2-77cd-aa83-c4d0fcd1a585', 'org_capabilities_name_key', NULL, NULL, 'u', '{019feb75-7eea-773e-9f04-d56bc085530e}', false, false, false, 'app', '{}'),
  ('019feb75-7ef2-7472-9947-32a57b4f400b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ee2-77cd-aa83-c4d0fcd1a585', 'org_capabilities_bitnum_key', NULL, NULL, 'u', '{019feb75-7eef-70d1-a6fa-04f2553d1156}', false, false, false, 'app', '{}'),
  ('019feb75-7f3e-7248-a42c-0719de590044', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7f1b-74ca-9a57-a7a77a490ba9', 'org_limits_name_actor_id_entity_id_key', NULL, NULL, 'u', '{019feb75-7f24-7361-8f5a-e5ba37cf5ab8,019feb75-7f27-72ea-944e-7ed6a1b21c8c,019feb75-7f38-7095-b331-c1a35b08d076}', false, false, false, 'app', '{}'),
  ('019feb75-7f51-764f-b344-eb77b790a40a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7f42-7e7f-adeb-651d0ecc673c', 'org_limit_defaults_name_key', NULL, NULL, 'u', '{019feb75-7f4b-790f-bad4-9f9fc8199b79}', false, false, false, 'app', '{}'),
  ('019feb75-7fd6-7d7d-a589-a9b7241abbc1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7fb2-7e3f-accd-1083624b72d7', 'org_limit_aggregates_name_entity_id_key', NULL, NULL, 'u', '{019feb75-7fbb-7ef6-8f94-f98de1df7af1,019feb75-7fbe-7f1e-b942-46946385cd9a}', false, false, false, 'app', '{}'),
  ('019feb75-8078-79c0-9396-6ae6512a254a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8069-7350-adb8-7640b3b672a2', 'org_limit_caps_defaults_name_key', NULL, NULL, 'u', '{019feb75-8072-778e-99c1-3e370fd62ff1}', false, false, false, 'app', '{}'),
  ('019feb75-808b-7425-b424-0618f51bdcd0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-807a-7c6b-acaa-eba03b0252bd', 'org_limit_caps_name_entity_id_key', NULL, NULL, 'u', '{019feb75-8083-77c4-91fa-d6eececd5616,019feb75-8087-70c2-851e-d0db35331257}', false, false, false, 'app', '{}'),
  ('019feb75-80bb-76c6-80d2-b91f1c44c25c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-80a3-7086-aac3-48a15ab63067', 'org_limit_warnings_name_entity_id_key', NULL, NULL, 'u', '{019feb75-80ac-7918-87b8-1b33dfa0953a,019feb75-80b5-72f1-b60c-70aea92c8e6a}', false, false, false, 'app', '{}'),
  ('019feb75-80da-702d-9bad-8841d88cb016', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-80bd-7a38-8322-a23264db0479', 'org_limit_warning_states_warning_id_actor_id_entity_id_key', NULL, NULL, 'u', '{019feb75-80c6-7a3a-8ab5-bcb21b841f8d,019feb75-80ca-7cc2-87cf-975b387ba16c,019feb75-80d3-7686-9962-6d729d9b3046}', false, false, false, 'app', '{}'),
  ('019feb75-813f-708f-9070-493e09d70aef', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8104-74c1-9285-19272f3f36c9', 'org_membership_defaults_entity_id_key', NULL, NULL, 'u', '{019feb75-813a-78f9-8e88-a5f63c8935c7}', false, false, false, 'app', '{}'),
  ('019feb75-815d-7ea3-a531-0ef6cd66aee8', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8141-7843-8e56-03ed77e58e70', 'org_membership_settings_entity_id_key', NULL, NULL, 'u', '{019feb75-8159-777a-bf78-ee16fcb5aa95}', false, false, false, 'app', '{}'),
  ('019feb75-8197-7ac6-b455-b29d1563f530', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-80eb-77cb-b434-9214851f2d3f', 'org_memberships_actor_id_entity_id_key', NULL, NULL, 'u', '{019feb75-818e-7621-9b64-4f8717885f6c,019feb75-8192-7ec5-9e8d-c23f8c93ad62}', false, false, false, 'app', '{}'),
  ('019feb75-81b4-7c54-b5fd-6366b8308e06', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-81a1-73c4-921f-2f503423abb6', 'org_members_actor_id_entity_id_key', NULL, NULL, 'u', '{019feb75-81ac-7629-bee3-3ab710d66abd,019feb75-81b0-7944-9eca-9af3167135e8}', false, false, false, 'app', '{}'),
  ('019feb75-824a-7a44-abba-31465d32a157', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8236-75fb-9dc6-db689017ed5d', 'org_member_profiles_membership_id_key', NULL, NULL, 'u', '{019feb75-8246-7313-adc6-e9e9a86219d1}', false, false, false, 'app', '{}'),
  ('019feb75-826f-7e0d-a9c5-08d458aa46b7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8236-75fb-9dc6-db689017ed5d', 'org_member_profiles_actor_id_entity_id_key', NULL, NULL, 'u', '{019feb75-8253-7b80-b962-452b1545326f,019feb75-824c-7f1d-bee7-0498863085fc}', false, false, false, 'app', '{}'),
  ('019feb75-8342-7d6c-84e4-33f63340a69f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-831c-7cc1-b679-81c2a7b7fb3e', 'org_profiles_name_entity_id_key', NULL, NULL, 'u', '{019feb75-8326-749f-a282-c7881f90ae12,019feb75-833c-7295-8647-b35d6457c115}', false, false, false, 'app', '{}'),
  ('019feb75-8345-7138-9a4e-0ffff1210cb7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-831c-7cc1-b679-81c2a7b7fb3e', 'org_profiles_slug_entity_id_key', NULL, NULL, 'u', '{019feb75-832a-7168-880d-adf027764944,019feb75-833c-7295-8647-b35d6457c115}', false, false, false, 'app', '{}'),
  ('019feb75-8360-7362-9920-63fe17954558', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-834e-7791-852a-6787b1c99790', 'org_profile_capabilities_profile_id_capability_id_key', NULL, NULL, 'u', '{019feb75-8356-721b-85e0-9de7131e9908,019feb75-835a-7143-86e5-98b1bb4c210b}', false, false, false, 'app', '{}'),
  ('019feb75-83da-7c51-bfc2-497e1b15c913', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-83c4-7884-89b2-49df42951434', 'org_membership_profiles_membership_id_profile_id_key', NULL, NULL, 'u', '{019feb75-83cd-7716-bb43-099c3f6ac92c,019feb75-83d1-7cf9-a0cf-55cde72087c7}', false, false, false, 'app', '{}'),
  ('019feb75-842f-7dc1-b370-1b6a784d898f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-840b-7395-9b85-b717d612a64d', 'org_profile_templates_name_key', NULL, NULL, 'u', '{019feb75-8419-7eec-b665-1edc58dbf006}', false, false, false, 'app', '{}'),
  ('019feb75-8432-765e-9583-a88e66d63e5c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-840b-7395-9b85-b717d612a64d', 'org_profile_templates_slug_key', NULL, NULL, 'u', '{019feb75-841e-7b94-8a12-6616d5fc36dc}', false, false, false, 'app', '{}'),
  ('019feb75-8465-71f8-9c11-b465e265f46c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8440-7e28-b081-063629bcb1bb', 'org_chart_edges_entity_id_child_id_key', NULL, NULL, 'u', '{019feb75-8452-7181-bce4-cd7f9558bac3,019feb75-8457-7a72-a832-9cd78bf7b51b}', false, false, false, 'app', '{}'),
  ('019feb75-8679-778f-9639-0b391ab29ba6', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8662-7462-bd4b-d8dee032dcdd', 'user_states_owner_id_name_key', NULL, NULL, 'u', '{019feb75-866e-7b54-9812-e12b1e551cc1,019feb75-8670-7d6c-ac19-d770fa499e88}', false, false, false, 'app', '{}'),
  ('019feb75-8705-7d0e-a30d-3e1aa48f5d99', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-86dd-7d4b-9a7a-f22c7ff73486', 'session_credentials_secret_hash_key', NULL, NULL, 'u', '{019feb75-86ef-7112-bb49-af8607e36494}', false, false, false, 'app', '{}'),
  ('019feb75-8708-79ca-b038-38341ae6d634', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-86dd-7d4b-9a7a-f22c7ff73486', 'session_credentials_key_id_key', NULL, NULL, 'u', '{019feb75-86ed-7c61-93cf-1f7426fe9f9d}', false, false, false, 'app', '{}'),
  ('019feb75-870a-7e01-af79-7535a825658d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-86dd-7d4b-9a7a-f22c7ff73486', 'session_credentials_ot_token_key', NULL, NULL, 'u', '{019feb75-86f6-7f6b-87fc-c6ddbbb5ee72}', false, false, false, 'app', '{}'),
  ('019feb75-87fa-77f2-9dae-a85a98cfde0e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87d7-70dd-9516-54c0ecf94600', 'session_secrets_session_id_name_key', NULL, NULL, 'u', '{019feb75-87e1-702b-b22a-18ad5de47259,019feb75-87ea-76bf-a89b-b7a6f571ec47}', false, false, false, 'app', '{}'),
  ('019feb75-8864-7704-bcbc-06903ea9b53e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8846-7b3d-84c7-196f76f0ae39', 'auth_ip_rate_limits_ip_address_ua_hash_action_key', NULL, NULL, 'u', '{019feb75-8850-70ce-be2f-c68bd7f6172a,019feb75-8853-7fdb-9e83-5ab85404a392,019feb75-8856-77f3-84bc-f5358aecdbe1}', false, false, false, 'app', '{}'),
  ('019feb75-888c-7fbf-9144-406137688b78', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-886c-70f1-ac1c-d171bba694aa', 'auth_rate_limits_subject_id_action_key', NULL, NULL, 'u', '{019feb75-8875-7c24-a9cf-d9991d1be59b,019feb75-8877-7b9f-a1c3-246302b1de9b}', false, false, false, 'app', '{}'),
  ('019feb75-8907-7953-82af-e8fcab9e385a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-88c9-752b-8ef8-9966727a744c', 'auth_user_devices_user_id_device_token_hash_key', NULL, NULL, 'u', '{019feb75-88d5-7365-974d-d741eda4cfd5,019feb75-88d7-7740-9650-ab53667e06be}', false, false, false, 'app', '{}'),
  ('019feb75-8935-7f01-a8cf-801ee965cea0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-891b-7bcd-9ed3-1fc29a40c6cd', 'user_secrets_owner_id_name_key', NULL, NULL, 'u', '{019feb75-8922-7e90-9eb7-8cf25e273c2e,019feb75-8924-7ca3-97b9-8040841fd4b7}', false, false, false, 'app', '{}'),
  ('019feb75-8a50-73b4-b61a-6a33717cb713', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a23-70f0-bc0a-c082a8c80fda', 'emails_email_key', NULL, NULL, 'u', '{019feb75-8a3d-74f4-a4ef-4bb7f8ae5f35}', false, false, false, 'app', '{}'),
  ('019feb75-8aa3-721f-9def-b87e795311b5', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a82-79e3-8a0d-c9114b559299', 'phone_numbers_number_key', NULL, NULL, 'u', '{019feb75-8a9a-732f-8851-03233cd3715c}', false, false, false, 'app', '{}'),
  ('019feb75-8b04-79f1-a153-ec31f4d4c7a4', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8ad3-74a3-a82a-14d661c634a7', 'webauthn_credentials_credential_id_key', NULL, NULL, 'u', '{019feb75-8ae5-7ef2-a585-300138041503}', false, false, false, 'app', '{}'),
  ('019feb75-8b07-7538-9d95-376ff17290b4', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8ad3-74a3-a82a-14d661c634a7', 'webauthn_credentials_webauthn_user_id_owner_id_key', NULL, NULL, 'u', '{019feb75-8aef-793f-9278-48ddeffef3fd,019feb75-8add-7187-bc7a-78e78648384f}', false, false, false, 'app', '{}'),
  ('019feb75-8b25-7359-aa2b-c77f808e25e2', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b13-7cf2-936a-d96be009a625', 'user_settings_securities_owner_id_key', NULL, NULL, 'u', '{019feb75-8b1c-7acc-a12e-e70d3453e448}', false, false, false, 'app', '{}'),
  ('019feb75-8b5f-7ca4-a9ee-0a743fe67623', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b42-77a4-83be-695a8efb04b9', 'connected_accounts_service_identifier_key', NULL, NULL, 'u', '{019feb75-8b54-782a-954b-bb2e33d5aaf7,019feb75-8b58-7eb9-bca1-6f33bdf7bb49}', false, false, false, 'app', '{}'),
  ('019feb75-8bb8-78b4-8f95-dfc48e640d1c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b7e-7a85-9b53-09c3e40fc17e', 'identity_providers_slug_key', NULL, NULL, 'u', '{019feb75-8b89-7a57-9ddd-c396dfb5dba0}', false, false, false, 'app', '{}'),
  ('019feb75-8c49-7109-8dad-532739ed63c0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8c00-72b9-b512-4719a73b24a5', 'app_invites_invite_token_key', NULL, NULL, 'u', '{019feb75-8c23-7a80-8600-ef56cc9601f8}', false, false, false, 'app', '{}'),
  ('019feb75-8c4c-7068-b9cc-40d6db0cd4bd', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8c00-72b9-b512-4719a73b24a5', 'app_invites_email_sender_id_key', NULL, NULL, 'u', '{019feb75-8c16-75ce-bee4-7c7d30cb97af,019feb75-8c20-79d9-8bcd-b9006f2a28d8}', false, false, false, 'app', '{}'),
  ('019feb75-8d07-721b-b7b1-6307d2db6038', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8cc1-72cd-aaa8-39befebe8af8', 'org_invites_invite_token_key', NULL, NULL, 'u', '{019feb75-8ce1-7fdc-a0a9-1b8873e1e07e}', false, false, false, 'app', '{}'),
  ('019feb75-8d11-75db-acf1-4b1e8c8ad71e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8cc1-72cd-aaa8-39befebe8af8', 'org_invites_email_sender_id_entity_id_key', NULL, NULL, 'u', '{019feb75-8cd2-7eb7-bcc1-486a59d0e5f2,019feb75-8cdd-768e-9424-6639d168511b,019feb75-8d09-7d31-b87e-99aac1bd8ea3}', false, false, false, 'app', '{}'),
  ('019feb75-91a8-7dd9-b44e-4c22f680eeea', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9184-707a-8a09-d8870969fe13', 'principal_entities_principal_id_entity_id_key', NULL, NULL, 'u', '{019feb75-9197-7c1f-b00b-3b61bdf1bff7,019feb75-919d-70fd-ac7e-a7cd9edfa5bd}', false, false, false, 'app', '{}'),
  ('019feb75-91e8-766e-b2da-52c71e525c0b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-91bb-7f0a-9d9d-fd451ffa01f4', 'principal_scope_overrides_principal_id_membership_type_key', NULL, NULL, 'u', '{019feb75-91d2-7bc6-87a2-b6fee84995b1,019feb75-91d8-794d-b414-74cf3bfd71f1}', false, false, false, 'app', '{}'),
  ('019feb75-9312-7ea0-b06c-54a39761525e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92cb-7779-a574-9f45714317cb', 'app_buckets_key_key', NULL, NULL, 'u', '{019feb75-92e8-7119-9336-c44ebf5fa999}', false, false, false, 'app', '{}'),
  ('019feb75-936a-7bfe-bbae-b36318e1dcd7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9326-7582-bae6-2409b3215b5d', 'app_files_bucket_id_key_key', NULL, NULL, 'u', '{019feb75-9343-7b25-a2fa-2902db4fcca6,019feb75-933c-7ba6-8631-53019e69fda8}', false, false, false, 'app', '{}');


SET session_replication_role TO DEFAULT;


