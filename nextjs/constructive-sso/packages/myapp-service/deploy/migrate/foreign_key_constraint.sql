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
  ('019fc104-f367-7816-bdfc-1e0fb59cc0d3', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'users_type_fkey', NULL, NULL, 'f', '{019fc104-f360-73a5-84f9-f29b901a6f66}', '019fc104-f348-71f2-afb5-970509c4ca3e', '{019fc104-f34f-7faf-8b9b-642b3d061ef0}', 'r', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-f50a-796c-b0f7-7d68dfe4b049', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4e1-7642-9736-e6d5dfaceeac', 'app_limits_actor_id_fkey', NULL, NULL, 'f', '{019fc104-f503-75a1-97a1-e45b646df2f6}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-f5b5-71de-b0a9-6b037a666ed9', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f597-75f3-a67f-5fbd5f0e3faa', 'app_limit_credits_default_limit_id_fkey', NULL, NULL, 'f', '{019fc104-f5ad-7e07-8853-ca6392695c75}', '019fc104-f551-7c69-b70e-4ba81d6e04f1', '{019fc104-f55a-7d61-a555-39d02d2dfa67}', 'r', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-f5c2-786d-bf49-458ec9db5cdf', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f597-75f3-a67f-5fbd5f0e3faa', 'app_limit_credits_actor_id_fkey', NULL, NULL, 'f', '{019fc104-f5bd-75d1-b3e0-0f19e5c3546a}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-f70a-73de-9ab6-c3061cdd3757', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f6e8-7711-ab24-10ebe24dbe7f', 'app_limit_credit_code_items_credit_code_id_fkey', NULL, NULL, 'f', '{019fc104-f702-7085-890f-78212c3b8b4f}', '019fc104-f69f-7fbe-a15f-ad7b4e36cce1', '{019fc104-f6aa-7f04-a582-7a6a3ba0ef42}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-f717-7791-bf11-d07e4a645384', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f6e8-7711-ab24-10ebe24dbe7f', 'app_limit_credit_code_items_default_limit_id_fkey', NULL, NULL, 'f', '{019fc104-f70f-73f4-b36d-4a7e6ce74b36}', '019fc104-f551-7c69-b70e-4ba81d6e04f1', '{019fc104-f55a-7d61-a555-39d02d2dfa67}', 'r', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-f769-7a29-8f21-6579eab38282', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f748-73ab-8b1b-1b6201c67237', 'app_limit_credit_redemptions_credit_code_id_fkey', NULL, NULL, 'f', '{019fc104-f761-7515-91fe-1bb38308d1b4}', '019fc104-f69f-7fbe-a15f-ad7b4e36cce1', '{019fc104-f6aa-7f04-a582-7a6a3ba0ef42}', 'r', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-f879-7e45-a618-6fe077232b74', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f856-7ccd-9517-b0ea87623895', 'app_limit_warning_states_warning_id_fkey', NULL, NULL, 'f', '{019fc104-f870-7e74-b7ba-f7248112ff3b}', '019fc104-f812-7521-9ae3-ca04fb0dcced', '{019fc104-f81c-7888-8c73-110e16f52f5a}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-f887-716d-9b99-e1833c062203', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f856-7ccd-9517-b0ea87623895', 'app_limit_warning_states_actor_id_fkey', NULL, NULL, 'f', '{019fc104-f87e-7692-aea7-adc8cd2ec2ba}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-fa31-7705-8c7f-908cd9714f83', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8d1-7179-8d86-1ce7702d0104', 'app_memberships_actor_id_fkey', NULL, NULL, 'f', '{019fc104-fa28-743c-a02f-1601b02766db}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-fa7b-7340-9d4b-068fc61dc0d2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fa51-7cc1-86be-cc37ef1d2058', 'app_admin_grants_actor_id_fkey', NULL, NULL, 'f', '{019fc104-fa75-7680-9339-a286d26ef3d7}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-fa8b-7005-a9c2-4798a956219d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fa51-7cc1-86be-cc37ef1d2058', 'app_admin_grants_grantor_id_fkey', NULL, NULL, 'f', '{019fc104-fa84-7053-911b-f7c8bc31ca6a}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-fad6-7337-96a6-7caa73751db3', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-faa9-779d-997d-b63d69f26665', 'app_owner_grants_actor_id_fkey', NULL, NULL, 'f', '{019fc104-facf-7ba9-a376-43d9f3d0f2e0}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-fae5-798f-99f8-67c72e291ff6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-faa9-779d-997d-b63d69f26665', 'app_owner_grants_grantor_id_fkey', NULL, NULL, 'f', '{019fc104-fadf-7245-8a83-432ed1593ff7}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-fb3b-7b82-b379-7ae4af91536c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb03-7075-b98c-fc2016e45ebb', 'app_grants_actor_id_fkey', NULL, NULL, 'f', '{019fc104-fb35-73c7-ba78-6de47a7363ab}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-fb4b-7b9f-bda9-c71a3e505d35', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb03-7075-b98c-fc2016e45ebb', 'app_grants_grantor_id_fkey', NULL, NULL, 'f', '{019fc104-fb44-7c3d-b153-cb13e031bd12}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-fb8f-7634-a362-e5e5ed039b02', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb69-7e31-ba8b-e7e1377de333', 'app_permission_default_permissions_permission_id_fkey', NULL, NULL, 'f', '{019fc104-fb83-7fc8-b958-d0f935542104}', '019fc104-f42b-7451-ad34-360101e6f0bb', '{019fc104-f436-73f7-9940-540fc33c75bc}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-fbd3-7b6a-ade3-6ff849d7956f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fbb0-7857-99af-321fc43e416c', 'app_permission_default_grants_permission_id_fkey', NULL, NULL, 'f', '{019fc104-fbca-74b2-999e-6090825fa4c5}', '019fc104-f42b-7451-ad34-360101e6f0bb', '{019fc104-f436-73f7-9940-540fc33c75bc}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc104-fbf1-7906-a98d-defb9bf4c2c2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fbb0-7857-99af-321fc43e416c', 'app_permission_default_grants_grantor_id_fkey', NULL, NULL, 'f', '{019fc104-fbea-7548-90cc-17007f8aba54}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-04a0-78c2-b26e-e04dbbe656ed', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0471-784c-9f94-cb05526be1f0', 'session_secrets_session_id_fkey', NULL, NULL, 'f', '{019fc105-0492-78a1-8d83-91add7441eca}', '019fc104-ff05-737a-9287-9dc91676dc85', '{019fc104-ff14-7b23-b730-02a7efe0d0e2}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-0957-75cf-9a7e-194ae521f1cf', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0837-7cb1-9c78-199827e949c6', 'auth_user_devices_user_id_fkey', NULL, NULL, 'f', '{019fc105-085b-75cc-a095-c1e20639fec2}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-0d36-75bb-93e2-f00cac3ec33e', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cf6-7075-9d35-6b418c5f8913', 'emails_owner_id_fkey', NULL, NULL, 'f', '{019fc105-0d25-7002-9320-e0a575962d45}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-0e4a-7b23-917c-76180ccff6ce', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0e13-7f38-9a06-598fb71d8c7b', 'phone_numbers_owner_id_fkey', NULL, NULL, 'f', '{019fc105-0e3a-778e-a521-c3b15353254f}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-0f66-71a1-83c7-73310367d70b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0f2e-795d-b36f-44859808a931', 'webauthn_credentials_owner_id_fkey', NULL, NULL, 'f', '{019fc105-0f56-74a7-98eb-fb4884d24331}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-10a7-7d7d-8fd2-9b289a516367', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-106d-7a9f-9f9f-9b50b89450ca', 'connected_accounts_owner_id_fkey', NULL, NULL, 'f', '{019fc105-1097-7566-8fb3-51baa26f1af9}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-1457-7887-8cbb-e95ad960ce8f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-13bf-7b4a-919a-37a5c5871c02', 'audit_log_auths_actor_id_fkey', NULL, NULL, 'f', '{019fc105-1406-7506-9271-db6f74e65431}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'n', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-184f-7fdb-b336-e1a2da188d91', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-17e6-7798-944f-48a70446be95', 'principals_owner_id_fkey', NULL, NULL, 'f', '{019fc105-183d-7e3c-be53-445348ffc9e1}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-186b-750d-9e69-0ed96d35abd9', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-17e6-7798-944f-48a70446be95', 'principals_user_id_fkey', NULL, NULL, 'f', '{019fc105-1858-7148-ac13-eb231c4a3b46}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-1950-7126-8a39-92b9392c278c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-18e2-7443-87f5-499f34c69054', 'principal_entities_principal_id_fkey', NULL, NULL, 'f', '{019fc105-193a-7dcf-b04b-944456f3fcfc}', '019fc105-17e6-7798-944f-48a70446be95', '{019fc105-17fb-7b50-94dd-22ee77428575}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-196a-749e-b333-d3a0775be948', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-18e2-7443-87f5-499f34c69054', 'principal_entities_entity_id_fkey', NULL, NULL, 'f', '{019fc105-1958-736a-a089-bbf4a4c492a0}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-1986-753f-8995-c1097e30ba22', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-18e2-7443-87f5-499f34c69054', 'principal_entities_owner_id_fkey', NULL, NULL, 'f', '{019fc105-1972-7a87-9a7b-35c6b5c15faa}', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '{019fc104-f301-73e6-9e20-30a43570a885}', 'c', 'a', false, '{}', false, false, 'app', '{}'),
  ('019fc105-1a38-72e5-81e0-7d2629559528', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-19cc-790a-b75f-2797f5dd0ac3', 'principal_scope_overrides_principal_id_fkey', NULL, NULL, 'f', '{019fc105-1a25-728f-8eaf-e99a02fd9dac}', '019fc105-17e6-7798-944f-48a70446be95', '{019fc105-17fb-7b50-94dd-22ee77428575}', 'c', 'a', false, '{}', false, false, 'app', '{}');


SET session_replication_role TO DEFAULT;


