-- Deploy: migrate/primary_key_constraint
-- made with <3 @ constructive.io

-- requires: migrate/policy


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

INSERT INTO metaschema_public.primary_key_constraint (
  id,
  database_id,
  table_id,
  name,
  type,
  field_ids,
  without_overlaps,
  is_deferrable,
  initially_deferred,
  smart_tags,
  category,
  tags
) VALUES
  ('019fa2a1-5038-751c-b5f9-2bfa949bc452', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'users_pkey', 'p', '{019fa2a1-502d-7c4d-bbff-501b165142a1}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5070-7384-a656-36b21f4762d9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5065-75d9-bf4c-86d761848b2b', 'role_types_pkey', 'p', '{019fa2a1-506c-7291-b12a-e11f3e42ae1d}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-50d3-79e7-afee-148209b1a15e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50bf-7eba-a17a-9839835e08f4', 'membership_types_pkey', 'p', '{019fa2a1-50cc-7060-be41-d6956a5bb843}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5144-7f45-b364-71f62d9cc996', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5131-7642-b999-a3637fd3f1a5', 'app_permissions_pkey', 'p', '{019fa2a1-513c-79cb-992b-327417b4c764}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5191-7cac-b48e-e0453acf9b33', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5182-755b-a123-1190a88df2cf', 'app_permission_defaults_pkey', 'p', '{019fa2a1-518a-773b-94d4-3f8e704c8e11}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-51ec-73cb-bc2e-6025269db666', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51d7-7525-a82f-f18b7765f445', 'app_limits_pkey', 'p', '{019fa2a1-51e2-7ad3-aa85-c5260401e1cf}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5255-73de-b368-23d411829704', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5245-7943-99d6-ab69b0046c4a', 'app_limit_defaults_pkey', 'p', '{019fa2a1-524e-706e-a931-faa298ea6d53}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5294-7b9e-88dd-84d96bb9b3f1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5285-725c-9bcd-65d477e277f4', 'app_limit_credits_pkey', 'p', '{019fa2a1-528d-7ab3-ae82-39b9d3dec839}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5336-7509-b151-956801c46751', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-52e7-7b9a-83c9-44ece4f9c7a4', 'app_limit_events_pkey', 'p', '{019fa2a1-52fc-7668-a55d-2047dbb14fec,019fa2a1-52f2-7d6f-b9c2-b6af48b1f8e5}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5389-78c7-82d4-03ac761b1061', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5378-7160-b636-5d7814a54a7c', 'app_limit_credit_codes_pkey', 'p', '{019fa2a1-5381-76aa-932e-6fa64e3e2c36}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-53d0-74b9-aeb8-eda1cd753dd0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-53be-7020-a577-17e52f91740f', 'app_limit_credit_code_items_pkey', 'p', '{019fa2a1-53c8-72bb-b821-cfbbb32c59d8}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5428-732c-8bed-554d065c9796', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5416-73f2-acac-2d0393ddb8cb', 'app_limit_credit_redemptions_pkey', 'p', '{019fa2a1-5420-72f5-9443-99c3abb9bb4f}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-547a-7e66-abbf-3a346152731d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5468-7986-ba62-d5ec673318b9', 'app_limit_caps_defaults_pkey', 'p', '{019fa2a1-5472-7980-ac94-f0d13ed755ac}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-54a8-7d03-9d93-f7386b579fbc', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5496-7d14-aea2-866a78236d8a', 'app_limit_caps_pkey', 'p', '{019fa2a1-549f-7a72-a8b3-793acc97e93b}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-54e9-7eef-829e-d79880c5869b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-54d8-72b7-8837-7d5008546c02', 'app_limit_warnings_pkey', 'p', '{019fa2a1-54e1-7455-b71d-a13074b45965}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5527-7b73-a56b-803f8ded37c1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5515-74cb-b03a-e1a7265372b4', 'app_limit_warning_states_pkey', 'p', '{019fa2a1-551f-7277-b33d-78455c12c6a3}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-55a6-7e74-9a41-b6b7e8ae8fc4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-558c-7bc2-b6aa-c20fbc1f8f2a', 'app_memberships_pkey', 'p', '{019fa2a1-559b-7b2e-a010-f4a0d3c4c9c1}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-55e0-7bb6-a886-bc20fc4a92be', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-55cd-7a92-9979-3b8d9bc899b3', 'app_membership_defaults_pkey', 'p', '{019fa2a1-55d8-71ac-abb6-3dcbd0fce849}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-570c-7ef3-8554-5da04e041d5a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-56f9-78f0-931f-4812580b70dd', 'app_admin_grants_pkey', 'p', '{019fa2a1-5703-78e7-9e32-f9003d0231ce}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5766-7dfa-9d17-4695a6f9463a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-574e-737f-9b1f-25f5eb8d9dd6', 'app_owner_grants_pkey', 'p', '{019fa2a1-575b-7d1c-846b-b61c98fbfbec}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-57c0-7d49-81a0-264936d16027', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-57ac-73c9-bd3e-65e6d7444548', 'app_grants_pkey', 'p', '{019fa2a1-57b7-70a0-a23a-4fd1ebb45257}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5828-7015-8e4c-09c6a00ed281', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5813-7ca8-bd2f-4f5cde8b71a6', 'app_permission_default_permissions_pkey', 'p', '{019fa2a1-581e-783b-adb1-ae00c02054a4}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5871-7481-a15a-7fb231586b36', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5856-7452-ad3a-45b1f4c4fc67', 'app_permission_default_grants_pkey', 'p', '{019fa2a1-5863-76fe-9480-bdbae8cfd26a}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5b5a-7e44-b925-13840e6a0464', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b1d-7b27-bab2-e3c469e536af', 'user_states_pkey', 'p', '{019fa2a1-5b2e-7142-9fe5-eccd5e1c8ebf}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5bdf-7791-a044-174b37f29a58', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5bbc-7d2a-a42f-af8235516fb4', 'sessions_pkey', 'p', '{019fa2a1-5bcf-7262-b8a0-6298c7d42865}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5ca5-713a-94f5-541921921c7d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5c8d-7633-a186-023c9c2285e6', 'session_credentials_pkey', 'p', '{019fa2a1-5c99-7b4a-ba0b-3b9b084cd5c5}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-5d9f-7098-8d97-b6877caa0af3', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5d87-7ece-8e60-1ad949ecfb19', 'app_settings_auths_pkey', 'p', '{019fa2a1-5d93-7ed8-b7cf-1331b5a2b978}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-6156-7d04-8adf-613bf2b261df', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-613c-724f-87a1-acb6049c0b8b', 'session_secrets_pkey', 'p', '{019fa2a1-6149-7368-b0de-2c9c92377065}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-61f1-7647-b6ce-38771861dfc4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-61d6-7dff-876e-13802d91c7ec', 'app_settings_rate_limits_pkey', 'p', '{019fa2a1-61e4-785b-ac46-8023e5205893}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-631b-7936-8ff3-76dcaad7007f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-62f0-7b99-aea9-87eac6e5fe19', 'auth_ip_rate_limits_pkey', 'p', '{019fa2a1-630e-7490-9788-dd0f13dd097b}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-63b6-7674-aa25-8551dfdbb629', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-639b-7ad6-b70a-a9e79a494ed0', 'auth_rate_limits_pkey', 'p', '{019fa2a1-63a9-78f4-906d-339c9744c2a7}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-6463-7791-abd6-0d7dc3af305c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-643a-7595-bd9e-8c50e40166bc', 'app_settings_devices_pkey', 'p', '{019fa2a1-644f-7075-81cb-de8714bcc493}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-6531-7e92-ad3f-14e07ad09cd2', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6514-72da-b9d9-3bdb2c772b8c', 'auth_user_devices_pkey', 'p', '{019fa2a1-6523-7276-8d1e-f75c47d27ce7}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-66cc-75ba-8807-6eacdc5c8e9d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6661-7502-b1a4-7ebfccb37ee9', 'user_secrets_pkey', 'p', '{019fa2a1-666f-7e1e-9783-0e56fafd22c7}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-683c-7bb2-bc3a-003af29a1a8e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-674f-73fa-9633-39edfbd13c6c', 'app_internal_secrets_pkey', 'p', '{019fa2a1-6761-733e-9acb-5d8dc667b120}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-69d0-73d3-80a5-57c885b7a019', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-69aa-7ba6-a7ef-3303f246936b', 'emails_pkey', 'p', '{019fa2a1-69be-7da4-969c-4710aa5a4253}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-6adb-75eb-a8cb-af13e189dcb0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6abc-79b5-a0c3-7f1bb20ebefd', 'phone_numbers_pkey', 'p', '{019fa2a1-6acc-7808-bc8d-78327ee29c3d}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-6bf2-713f-be22-da1ac140e9f1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6bd3-7a50-b4af-3c2cb7aee426', 'webauthn_credentials_pkey', 'p', '{019fa2a1-6be2-7db4-bec3-8b59b227e569}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-6d28-76aa-b3a0-20bcfeff63aa', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6d06-750a-9c65-845342800227', 'connected_accounts_pkey', 'p', '{019fa2a1-6d17-7124-947e-503091d48c8b}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-6e24-7de4-9b8e-a4ad0f317d28', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6e03-77a5-8d95-46056bdd7ccf', 'identity_providers_pkey', 'p', '{019fa2a1-6e13-7815-8fd3-261e273bf2d5}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-713b-7281-bb4b-6f8c5ff707bb', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-703c-73a4-bcd4-ef0ed194b005', 'audit_log_auths_pkey', 'p', '{019fa2a1-70e7-7803-a305-6394226eb534,019fa2a1-7052-7efa-a69d-61e115c151c5}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-730d-7dfd-b46c-d3fda0015c79', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-72e9-73af-9d7e-46dedcbda5ad', 'principals_pkey', 'p', '{019fa2a1-72fc-72ce-8dd6-c31176eca390}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-73ff-78d1-a49c-ae24864780ee', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-73db-7463-ae1b-141b8847e6ed', 'principal_entities_pkey', 'p', '{019fa2a1-73ea-7e00-9c75-05d5c1312a40}', false, false, false, NULL, 'app', '{}'),
  ('019fa2a1-74f6-7c7a-bfe6-6344222e6fed', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-74cf-7e12-bb6b-5a4db46c9efb', 'principal_scope_overrides_pkey', 'p', '{019fa2a1-74e3-73a1-8935-9840f71f9109}', false, false, false, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


