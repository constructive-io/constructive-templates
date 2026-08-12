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
  ('019fc104-f30f-72be-b26d-476773c64902', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'users_pkey', 'p', '{019fc104-f301-73e6-9e20-30a43570a885}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f354-7912-b94f-af5d98735dbd', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f348-71f2-afb5-970509c4ca3e', 'role_types_pkey', 'p', '{019fc104-f34f-7faf-8b9b-642b3d061ef0}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f3c8-7c96-9ab3-dfe77c7c0321', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f3b3-7db4-9f2a-97645203d652', 'membership_types_pkey', 'p', '{019fc104-f3c0-7a3f-8a9c-e695bab1ee58}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f43e-7901-a2fa-7182d3b0bf2f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f42b-7451-ad34-360101e6f0bb', 'app_permissions_pkey', 'p', '{019fc104-f436-73f7-9940-540fc33c75bc}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f496-788b-b333-fe902820c90d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f485-7df6-ba4b-f9ea1f7a605a', 'app_permission_defaults_pkey', 'p', '{019fc104-f48f-7247-b45d-848a7028bf0f}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f4f8-7f0b-93c3-91e21e4400a4', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4e1-7642-9736-e6d5dfaceeac', 'app_limits_pkey', 'p', '{019fc104-f4ef-73f2-85ee-2ab79ce415ee}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f562-7644-a4f9-e8899e4a2861', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f551-7c69-b70e-4ba81d6e04f1', 'app_limit_defaults_pkey', 'p', '{019fc104-f55a-7d61-a555-39d02d2dfa67}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f5a9-7af5-8c08-8fb5e9039c2e', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f597-75f3-a67f-5fbd5f0e3faa', 'app_limit_credits_pkey', 'p', '{019fc104-f5a1-7766-8c32-650b0c818283}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f657-742a-85ee-4e11c2d29ced', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f604-726c-8678-a802736e11b8', 'app_limit_events_pkey', 'p', '{019fc104-f61b-76dc-bbec-fedf5db309d4,019fc104-f610-7ed4-afdd-4ad0e105debc}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f6b3-7bbe-a555-a41b04af46bb', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f69f-7fbe-a15f-ad7b4e36cce1', 'app_limit_credit_codes_pkey', 'p', '{019fc104-f6aa-7f04-a582-7a6a3ba0ef42}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f6fd-7450-a89e-ba5264821ce5', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f6e8-7711-ab24-10ebe24dbe7f', 'app_limit_credit_code_items_pkey', 'p', '{019fc104-f6f4-7513-ba8c-1ff0069533a8}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f75c-7b2c-a33d-411229bb1113', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f748-73ab-8b1b-1b6201c67237', 'app_limit_credit_redemptions_pkey', 'p', '{019fc104-f753-747d-a05f-f37fc114b472}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f7ac-79c3-8282-05fc79b0b264', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f798-7c31-b507-71cb546e48e8', 'app_limit_caps_defaults_pkey', 'p', '{019fc104-f7a3-79dc-9c47-74809968e671}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f7de-7d93-9ddb-9595e81e1147', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f7cb-724e-9322-353d4f589b28', 'app_limit_caps_pkey', 'p', '{019fc104-f7d4-7ce4-afc0-416b378a1494}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f826-79cd-b186-31bb718e34c1', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f812-7521-9ae3-ca04fb0dcced', 'app_limit_warnings_pkey', 'p', '{019fc104-f81c-7888-8c73-110e16f52f5a}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f86c-7507-a390-953f11acaf51', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f856-7ccd-9517-b0ea87623895', 'app_limit_warning_states_pkey', 'p', '{019fc104-f862-702e-a807-cfd6bc284667}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f8ec-7882-9bbe-744fe3e0820a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8d1-7179-8d86-1ce7702d0104', 'app_memberships_pkey', 'p', '{019fc104-f8e0-795d-8651-311b0333898d}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-f930-7079-83c6-d8b6ba1f19eb', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f919-7c68-b65c-ead0b86f3cc4', 'app_membership_defaults_pkey', 'p', '{019fc104-f925-7514-acc5-1b04648b8f17}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-fa65-7b04-9194-4be5d1d7f0d0', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fa51-7cc1-86be-cc37ef1d2058', 'app_admin_grants_pkey', 'p', '{019fc104-fa5c-7483-8e19-e171dba98e09}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-fabe-7354-8f7a-1c4c0054cb06', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-faa9-779d-997d-b63d69f26665', 'app_owner_grants_pkey', 'p', '{019fc104-fab4-79bc-a410-a02b9c700691}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-fb16-7cde-b370-f44cd0e6df5c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb03-7075-b98c-fc2016e45ebb', 'app_grants_pkey', 'p', '{019fc104-fb0d-73c2-a49f-b417509df369}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-fb7f-71b4-8f0a-1fc83f1b208f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb69-7e31-ba8b-e7e1377de333', 'app_permission_default_permissions_pkey', 'p', '{019fc104-fb75-717e-bccf-2ad8ed042e4c}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-fbc5-7979-9286-0b9aae77fe00', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fbb0-7857-99af-321fc43e416c', 'app_permission_default_grants_pkey', 'p', '{019fc104-fbbb-7712-8505-66171aa4fce7}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-fea9-7a82-b264-02075eddee5f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe6f-719a-8b3f-c157587194b5', 'user_states_pkey', 'p', '{019fc104-fe7e-7492-843b-c64518c5962e}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-ff24-7c5c-ae79-e7e087f3eca3', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-ff05-737a-9287-9dc91676dc85', 'sessions_pkey', 'p', '{019fc104-ff14-7b23-b730-02a7efe0d0e2}', false, false, false, NULL, 'app', '{}'),
  ('019fc104-ffea-7c2c-8693-5734213a4c59', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-ffd2-7869-bc0e-15e9e9f99044', 'session_credentials_pkey', 'p', '{019fc104-ffdf-77c9-ab9e-6a04b877a37e}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-00e1-7f26-9c6e-a5ef2317783f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-00c9-74c6-8795-eb7e04e1c73c', 'app_settings_auths_pkey', 'p', '{019fc105-00d6-7ba9-8a07-4103d5da64cf}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-048c-7797-a54b-b1252085e170', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0471-784c-9f94-cb05526be1f0', 'session_secrets_pkey', 'p', '{019fc105-047e-7e21-8021-3214c3287e1d}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-0523-7f63-8717-845f65f084aa', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0509-7e23-bf8c-4957678ad39c', 'app_settings_rate_limits_pkey', 'p', '{019fc105-0517-78a9-a5c2-e2ed946d98af}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-062c-7ead-bc81-c6ab038a2826', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0611-7e5d-8c39-47e53c2a80d2', 'auth_ip_rate_limits_pkey', 'p', '{019fc105-061f-756d-8300-da7416ae4f3f}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-06d9-7773-a4e8-7bad8a06590b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-06bc-74e6-9286-763950a36e86', 'auth_rate_limits_pkey', 'p', '{019fc105-06cb-740b-80c5-4f0dc39e81e9}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-077f-799f-b645-b579ed181ec0', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0761-7e41-b7c9-5d562a017d29', 'app_settings_devices_pkey', 'p', '{019fc105-0770-72cb-bc0f-7a7c4937ec42}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-0854-7d20-9385-3e9837aa4080', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0837-7cb1-9c78-199827e949c6', 'auth_user_devices_pkey', 'p', '{019fc105-0846-75ce-85e6-ace725818180}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-0a05-773c-bf5b-c1319e24b6ed', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0996-7bb7-8ecb-595462857b72', 'user_secrets_pkey', 'p', '{019fc105-09a5-78df-98ad-096d85b79f89}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-0b85-7103-bbb2-6f18acd9c25e', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a8c-74f6-873c-134a7419f69c', 'app_internal_secrets_pkey', 'p', '{019fc105-0a9d-7d32-bb37-d8ef6cdd3f79}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-0d1d-7278-a979-a5b02170d85a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cf6-7075-9d35-6b418c5f8913', 'emails_pkey', 'p', '{019fc105-0d0a-76e7-9eda-6245d3801c90}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-0e33-7fa8-aa7d-2ba0ffa567fe', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0e13-7f38-9a06-598fb71d8c7b', 'phone_numbers_pkey', 'p', '{019fc105-0e23-78b1-9fc5-ef47bae820b3}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-0f4f-715c-bc01-715d6008583a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0f2e-795d-b36f-44859808a931', 'webauthn_credentials_pkey', 'p', '{019fc105-0f3e-7249-b44f-6df1b2fc2511}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-108f-7bce-8da8-ecc8047dd806', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-106d-7a9f-9f9f-9b50b89450ca', 'connected_accounts_pkey', 'p', '{019fc105-107f-700d-ba6f-c82de9031057}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-1193-7a48-94f3-7b90dcee09cc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1171-72ca-849a-5ad7ac0b2fd3', 'identity_providers_pkey', 'p', '{019fc105-1182-713e-a03b-18e928e06923}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-14cc-7cac-9e5c-fa561135d3cc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-13bf-7b4a-919a-37a5c5871c02', 'audit_log_auths_pkey', 'p', '{019fc105-147a-7664-ab8d-cb5ade70c20c,019fc105-13d8-70c3-9e8d-b4ef208c1d93}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-180f-75a2-a42f-d76b7fb0892d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-17e6-7798-944f-48a70446be95', 'principals_pkey', 'p', '{019fc105-17fb-7b50-94dd-22ee77428575}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-1909-7e09-924a-c403ce3690cf', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-18e2-7443-87f5-499f34c69054', 'principal_entities_pkey', 'p', '{019fc105-18f4-7367-aa4d-590bdc13e364}', false, false, false, NULL, 'app', '{}'),
  ('019fc105-19f2-7c37-bb19-76d552d643f9', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-19cc-790a-b75f-2797f5dd0ac3', 'principal_scope_overrides_pkey', 'p', '{019fc105-19df-717b-aa9e-6a09061c592c}', false, false, false, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


