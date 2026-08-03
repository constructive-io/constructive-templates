-- Deploy: migrate/table_grant
-- made with <3 @ constructive.io

-- requires: migrate/primary_key_constraint


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

INSERT INTO metaschema_public.table_grant (
  id,
  database_id,
  table_id,
  privilege,
  grantee_name,
  field_ids,
  is_grant
) VALUES
  ('019fc104-f38b-7542-9c2e-05b9dd79bfd0', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'select', 'authenticated', '{}', true),
  ('019fc104-f38e-758a-9107-884365b38947', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'delete', 'authenticated', '{}', true),
  ('019fc104-f391-721a-a2c1-ecae963c0b16', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'update', 'authenticated', '{019fc104-f315-7ce3-9fe4-2862b2c9c1ae,019fc104-f324-7b70-acd8-17a87d8086d2,019fc104-f32b-7f79-b422-3700969227c2}', true),
  ('019fc104-f394-7020-b2d0-cc09599835f9', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'insert', 'authenticated', '{019fc104-f360-73a5-84f9-f29b901a6f66,019fc104-f324-7b70-acd8-17a87d8086d2,019fc104-f32b-7f79-b422-3700969227c2,019fc104-f315-7ce3-9fe4-2862b2c9c1ae}', true),
  ('019fc104-f3f5-7462-9acb-6384b352086c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f3b3-7db4-9f2a-97645203d652', 'select', 'authenticated', '{}', true),
  ('019fc104-f46d-727c-9db9-e4c69451fa82', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f42b-7451-ad34-360101e6f0bb', 'select', 'authenticated', '{}', true),
  ('019fc104-f5e6-7453-9abd-9e8ef92d3d9d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f597-75f3-a67f-5fbd5f0e3faa', 'insert', 'authenticated', '{}', true),
  ('019fc104-f5ea-72c4-a00d-7b9fbea6d554', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f597-75f3-a67f-5fbd5f0e3faa', 'select', 'authenticated', '{}', true),
  ('019fc104-f65e-7bb5-95e1-893a1e07eea2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f604-726c-8678-a802736e11b8', 'insert', 'authenticated', '{}', true),
  ('019fc104-f661-75f9-bb83-91cca33bf102', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f604-726c-8678-a802736e11b8', 'select', 'authenticated', '{}', true),
  ('019fc104-f6de-7646-81fd-b5eee26e0496', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f69f-7fbe-a15f-ad7b4e36cce1', 'insert', 'authenticated', '{}', true),
  ('019fc104-f6e0-7e4f-b0b5-ee1925ffccad', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f69f-7fbe-a15f-ad7b4e36cce1', 'select', 'authenticated', '{}', true),
  ('019fc104-f6e3-767d-ac52-91deb7196782', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f69f-7fbe-a15f-ad7b4e36cce1', 'update', 'authenticated', '{}', true),
  ('019fc104-f6e5-7d09-9aed-1966f75d01e6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f69f-7fbe-a15f-ad7b4e36cce1', 'delete', 'authenticated', '{}', true),
  ('019fc104-f73d-7323-8e41-0faba497e015', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f6e8-7711-ab24-10ebe24dbe7f', 'insert', 'authenticated', '{}', true),
  ('019fc104-f73f-7e34-a6e6-a20e797b058b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f6e8-7711-ab24-10ebe24dbe7f', 'select', 'authenticated', '{}', true),
  ('019fc104-f742-7a84-9a22-e58dc597012e', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f6e8-7711-ab24-10ebe24dbe7f', 'update', 'authenticated', '{}', true),
  ('019fc104-f745-76e8-b19b-9f01386f2c01', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f6e8-7711-ab24-10ebe24dbe7f', 'delete', 'authenticated', '{}', true),
  ('019fc104-f78a-7aab-8d13-2b307ec337fd', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f748-73ab-8b1b-1b6201c67237', 'insert', 'authenticated', '{}', true),
  ('019fc104-f78d-7674-981e-6c06249452e6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f748-73ab-8b1b-1b6201c67237', 'select', 'authenticated', '{}', true),
  ('019fc104-f998-7748-9abc-3b48c0795cd2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f959-78a1-85cf-b54b5e2847b4', 'select', 'public', '{}', true),
  ('019fc104-fc53-7f55-a4db-ff4c32b38c34', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f42b-7451-ad34-360101e6f0bb', 'insert', 'authenticated', '{}', true),
  ('019fc104-fc57-7f79-8d17-9cf5a5c285b0', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f42b-7451-ad34-360101e6f0bb', 'update', 'authenticated', '{}', true),
  ('019fc104-fc5b-78d6-8f87-8a9f79ddde40', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f42b-7451-ad34-360101e6f0bb', 'delete', 'authenticated', '{}', true),
  ('019fc104-fc77-7bb7-97ca-5c955cafc733', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f485-7df6-ba4b-f9ea1f7a605a', 'insert', 'authenticated', '{}', true),
  ('019fc104-fc7a-794d-8137-4a524b8942c6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f485-7df6-ba4b-f9ea1f7a605a', 'select', 'authenticated', '{}', true),
  ('019fc104-fc7d-7aa0-94a8-82fd8bc28ce7', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f485-7df6-ba4b-f9ea1f7a605a', 'delete', 'authenticated', '{}', true),
  ('019fc104-fc94-73e4-91c1-b2154902d969', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4e1-7642-9736-e6d5dfaceeac', 'insert', 'authenticated', '{}', true),
  ('019fc104-fc97-7284-a0f5-8d7b8a19e25d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4e1-7642-9736-e6d5dfaceeac', 'select', 'authenticated', '{}', true),
  ('019fc104-fc9a-73d2-9624-e0fec4933c7f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4e1-7642-9736-e6d5dfaceeac', 'update', 'authenticated', '{}', true),
  ('019fc104-fc9e-7acf-b10e-4bd7d931619d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4e1-7642-9736-e6d5dfaceeac', 'delete', 'authenticated', '{}', true),
  ('019fc104-fd0e-71c2-ba8a-d54a8824e3bf', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f551-7c69-b70e-4ba81d6e04f1', 'insert', 'authenticated', '{}', true),
  ('019fc104-fd11-7275-a605-fc7f212ffcb9', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f551-7c69-b70e-4ba81d6e04f1', 'select', 'authenticated', '{}', true),
  ('019fc104-fd14-7613-8cbc-6b711791bb26', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f551-7c69-b70e-4ba81d6e04f1', 'update', 'authenticated', '{}', true),
  ('019fc104-fd17-76e2-ac95-66aee7bc49d6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f551-7c69-b70e-4ba81d6e04f1', 'delete', 'authenticated', '{}', true),
  ('019fc104-fd37-793b-b81b-486f83dc8df8', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f798-7c31-b507-71cb546e48e8', 'select', 'authenticated', '{}', true),
  ('019fc104-fd3f-7c46-83d8-d022c2bc6bd3', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f798-7c31-b507-71cb546e48e8', 'insert', 'authenticated', '{}', true),
  ('019fc104-fd42-7c29-9b55-25acf5369f8d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f798-7c31-b507-71cb546e48e8', 'update', 'authenticated', '{}', true),
  ('019fc104-fd45-7edf-a839-8308ba8c9eb2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f798-7c31-b507-71cb546e48e8', 'delete', 'authenticated', '{}', true),
  ('019fc104-fd5e-7e82-9179-5f2f42e87747', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f7cb-724e-9322-353d4f589b28', 'insert', 'authenticated', '{}', true),
  ('019fc104-fd61-7c57-970c-0a9295ae907c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f7cb-724e-9322-353d4f589b28', 'select', 'authenticated', '{}', true),
  ('019fc104-fd64-7bae-be90-cb3f126b6537', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f7cb-724e-9322-353d4f589b28', 'update', 'authenticated', '{}', true),
  ('019fc104-fd67-7af7-ba6f-040381d60d4b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f7cb-724e-9322-353d4f589b28', 'delete', 'authenticated', '{}', true),
  ('019fc104-fd89-7df6-9713-73570871911b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8d1-7179-8d86-1ce7702d0104', 'select', 'authenticated', '{}', true),
  ('019fc104-fd8d-73f7-b5ee-7649cd1eae62', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8d1-7179-8d86-1ce7702d0104', 'update', 'authenticated', '{019fc104-f9c8-7b1e-bd15-86235368595a,019fc104-f9bb-7daa-a93d-bc9082fa8be8,019fc104-f9df-7d07-86fc-6fc933db77f4,019fc104-f9d4-76e6-9dee-d5c688a74c01}', true),
  ('019fc104-fdae-7b49-9916-1d0fd56323e9', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f919-7c68-b65c-ead0b86f3cc4', 'insert', 'authenticated', '{}', true),
  ('019fc104-fdb1-7f2d-9ba5-1ff708c432ba', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f919-7c68-b65c-ead0b86f3cc4', 'select', 'authenticated', '{}', true),
  ('019fc104-fdb5-76ca-b7ea-8ee73f49e97b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f919-7c68-b65c-ead0b86f3cc4', 'update', 'authenticated', '{}', true),
  ('019fc104-fdb8-7c80-a4ca-09ee6e97e3ac', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f919-7c68-b65c-ead0b86f3cc4', 'delete', 'authenticated', '{}', true),
  ('019fc104-fdda-73c5-a6f5-2e28638166e0', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb03-7075-b98c-fc2016e45ebb', 'insert', 'authenticated', '{}', true),
  ('019fc104-fddd-761e-a8ec-4ef9295ca86a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb03-7075-b98c-fc2016e45ebb', 'select', 'authenticated', '{}', true),
  ('019fc104-fdf2-7572-a1a5-412e565465ba', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fa51-7cc1-86be-cc37ef1d2058', 'insert', 'authenticated', '{}', true),
  ('019fc104-fdf5-7760-a344-0c5ece90fb6d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fa51-7cc1-86be-cc37ef1d2058', 'select', 'authenticated', '{}', true),
  ('019fc104-fe09-78c8-9b36-5169b4704058', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-faa9-779d-997d-b63d69f26665', 'insert', 'authenticated', '{}', true),
  ('019fc104-fe0c-799a-b4b3-811da872965c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-faa9-779d-997d-b63d69f26665', 'select', 'authenticated', '{}', true),
  ('019fc104-fe1e-7e13-9613-ebd722909bf9', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb69-7e31-ba8b-e7e1377de333', 'select', 'authenticated', '{}', true),
  ('019fc104-fe21-7f0f-8b6e-0ddc2375dc75', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb69-7e31-ba8b-e7e1377de333', 'insert', 'authenticated', '{}', true),
  ('019fc104-fe25-71ea-baf5-b4486b4b3d2d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fb69-7e31-ba8b-e7e1377de333', 'delete', 'authenticated', '{}', true),
  ('019fc104-fe3c-7ac9-a8d7-d60846a6fb70', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fbb0-7857-99af-321fc43e416c', 'select', 'authenticated', '{}', true),
  ('019fc104-fe3f-7cbe-bcdb-934b56618d19', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fbb0-7857-99af-321fc43e416c', 'insert', 'authenticated', '{}', true),
  ('019fc104-feb8-78e0-9635-93f9c3f30b48', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe6f-719a-8b3f-c157587194b5', 'insert', 'authenticated', '{}', true),
  ('019fc104-febc-72f5-96e1-47af7bb8ad64', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe6f-719a-8b3f-c157587194b5', 'update', 'authenticated', '{}', true),
  ('019fc104-febf-7226-bba0-a6a1e2f77795', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe6f-719a-8b3f-c157587194b5', 'delete', 'authenticated', '{}', true),
  ('019fc105-00c5-7c30-9673-14a10fd1dfe1', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-ffd2-7869-bc0e-15e9e9f99044', 'select', 'authenticated', '{}', true),
  ('019fc105-040e-7912-a7cb-e0462ab95f50', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-00c9-74c6-8795-eb7e04e1c73c', 'select', 'authenticated', '{}', true),
  ('019fc105-0411-7fae-a0b1-5db37d625d08', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-00c9-74c6-8795-eb7e04e1c73c', 'update', 'authenticated', '{}', true),
  ('019fc105-05f1-7ac0-958d-b5d839a4c55c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0509-7e23-bf8c-4957678ad39c', 'select', 'authenticated', '{}', true),
  ('019fc105-05f5-78fd-a31d-5f3d7feb27ff', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0509-7e23-bf8c-4957678ad39c', 'update', 'authenticated', '{}', true),
  ('019fc105-0817-7a28-8df8-e175ecbb5d58', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0761-7e41-b7c9-5d562a017d29', 'select', 'authenticated', '{}', true),
  ('019fc105-081b-74a3-9b34-1d180cc1d678', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0761-7e41-b7c9-5d562a017d29', 'update', 'authenticated', '{}', true),
  ('019fc105-097a-75e1-b2ba-fc115d740690', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0837-7cb1-9c78-199827e949c6', 'select', 'authenticated', '{}', true),
  ('019fc105-097e-732d-869b-e94d9f78642d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0837-7cb1-9c78-199827e949c6', 'update', 'authenticated', '{}', true),
  ('019fc105-0982-7046-9935-170dc88e8d8f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0837-7cb1-9c78-199827e949c6', 'delete', 'authenticated', '{}', true),
  ('019fc105-0a15-767d-b584-ed820ce42637', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0996-7bb7-8ecb-595462857b72', 'insert', 'authenticated', '{}', true),
  ('019fc105-0a19-7096-9a99-aaa741b9a325', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0996-7bb7-8ecb-595462857b72', 'update', 'authenticated', '{}', true),
  ('019fc105-0a1c-7d45-b13f-f23cfb8c1930', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0996-7bb7-8ecb-595462857b72', 'delete', 'authenticated', '{}', true),
  ('019fc105-0b97-706b-ab79-70d28d07c14d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a8c-74f6-873c-134a7419f69c', 'select', 'authenticated', '{}', true),
  ('019fc105-0b9b-784e-a319-e1700aa43b42', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a8c-74f6-873c-134a7419f69c', 'insert', 'authenticated', '{}', true),
  ('019fc105-0b9f-79bf-8354-0a723a19fe17', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a8c-74f6-873c-134a7419f69c', 'update', 'authenticated', '{}', true),
  ('019fc105-0ba3-7b94-ad53-6caf22aadd1f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a8c-74f6-873c-134a7419f69c', 'delete', 'authenticated', '{}', true),
  ('019fc105-0dbf-7c01-a207-d376eb0b10ba', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cf6-7075-9d35-6b418c5f8913', 'insert', 'authenticated', '{019fc105-0d44-7e33-a65c-169f0f57f400,019fc105-0d25-7002-9320-e0a575962d45,019fc105-0d72-7f19-9a3a-925b3f9195d0,019fc105-0d87-78e6-bb1d-50ade48d4000}', true),
  ('019fc105-0dc4-746b-9316-0e6db87ac49c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cf6-7075-9d35-6b418c5f8913', 'update', 'authenticated', '{019fc105-0d72-7f19-9a3a-925b3f9195d0,019fc105-0d87-78e6-bb1d-50ade48d4000}', true),
  ('019fc105-0dc8-7777-830a-7779c2ff0c21', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cf6-7075-9d35-6b418c5f8913', 'select', 'authenticated', '{}', true),
  ('019fc105-0dcc-783d-a35c-e83bd95daef0', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cf6-7075-9d35-6b418c5f8913', 'delete', 'authenticated', '{}', true),
  ('019fc105-0ed7-7c27-877a-346e041706cb', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0e13-7f38-9a06-598fb71d8c7b', 'insert', 'authenticated', '{019fc105-0e57-7183-96e0-defd2f0dbefb,019fc105-0e6a-787c-830e-817764099b72,019fc105-0e3a-778e-a521-c3b15353254f,019fc105-0e8e-7280-a173-ee94bbdf69d3,019fc105-0ea1-7b6e-afdc-d325ff0d49a8}', true),
  ('019fc105-0edc-7d67-b09c-fbe65cabc602', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0e13-7f38-9a06-598fb71d8c7b', 'update', 'authenticated', '{019fc105-0e8e-7280-a173-ee94bbdf69d3,019fc105-0ea1-7b6e-afdc-d325ff0d49a8}', true),
  ('019fc105-0ee1-7e5c-9011-93513898b724', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0e13-7f38-9a06-598fb71d8c7b', 'select', 'authenticated', '{}', true),
  ('019fc105-0ee6-739d-a69c-f2be809864bc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0e13-7f38-9a06-598fb71d8c7b', 'delete', 'authenticated', '{}', true),
  ('019fc105-1048-79a7-91cf-2c41cca7b941', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0f2e-795d-b36f-44859808a931', 'select', 'authenticated', '{}', true),
  ('019fc105-104d-7a71-91a9-e4bd65308393', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0f2e-795d-b36f-44859808a931', 'delete', 'authenticated', '{}', true),
  ('019fc105-1053-72ff-afee-a7cd74761fa0', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0f2e-795d-b36f-44859808a931', 'update', 'authenticated', '{019fc105-0fff-7d65-8d23-2bc5cf3bea5d}', true),
  ('019fc105-1130-75f8-b05d-409511085a2d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-106d-7a9f-9f9f-9b50b89450ca', 'select', 'authenticated', '{}', true),
  ('019fc105-132a-7082-8c5b-58eb50eb2f95', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1171-72ca-849a-5ad7ac0b2fd3', 'select', 'authenticated', '{019fc105-119b-7373-861d-99bc15cf98fc,019fc105-11ad-7f0b-821a-421b9b738b98,019fc105-11be-7c9c-854c-48633ee7d389,019fc105-11ce-7bdc-8c9f-6099b2ece03d}', true),
  ('019fc105-132e-777d-91d0-123e2322d28a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1171-72ca-849a-5ad7ac0b2fd3', 'insert', 'authenticated', '{}', true),
  ('019fc105-1332-7f6a-b925-1ba7bffa24f5', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1171-72ca-849a-5ad7ac0b2fd3', 'update', 'authenticated', '{}', true),
  ('019fc105-1337-7a0e-8377-ef682f4456be', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1171-72ca-849a-5ad7ac0b2fd3', 'delete', 'authenticated', '{}', true),
  ('019fc105-14e3-7986-b151-f72b35986fac', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-13bf-7b4a-919a-37a5c5871c02', 'select', 'authenticated', '{}', true),
  ('019fc105-19af-7b68-b098-8d4220ef63e9', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-17e6-7798-944f-48a70446be95', 'select', 'authenticated', '{}', true),
  ('019fc105-19c1-75bc-a9a0-eca1ab0fb32f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-18e2-7443-87f5-499f34c69054', 'select', 'authenticated', '{}', true),
  ('019fc105-1ac3-7f43-9963-57b57e8221a5', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-19cc-790a-b75f-2797f5dd0ac3', 'select', 'authenticated', '{}', true);


SET session_replication_role TO DEFAULT;


