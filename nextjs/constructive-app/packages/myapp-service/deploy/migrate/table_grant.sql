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
  ('019fa2a1-509c-769d-9132-cb61158acc46', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'select', 'authenticated', '{}', true),
  ('019fa2a1-509f-70f1-901d-b01c3eaa6c0b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-50a1-7723-a35f-2c445057ef79', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'update', 'authenticated', '{019fa2a1-503c-7fc0-a00a-4eb05fdea62f,019fa2a1-5048-7874-b9b6-ecb3b316d78c,019fa2a1-504e-750b-89ab-1cb41a0f60c0}', true),
  ('019fa2a1-50a3-7dd0-b9f6-0b3462daa28a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'insert', 'authenticated', '{019fa2a1-507a-7958-a296-28528bcf1ff5,019fa2a1-5048-7874-b9b6-ecb3b316d78c,019fa2a1-504e-750b-89ab-1cb41a0f60c0,019fa2a1-503c-7fc0-a00a-4eb05fdea62f}', true),
  ('019fa2a1-5100-725e-9ce4-8dd7279a8d2b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50bf-7eba-a17a-9839835e08f4', 'select', 'authenticated', '{}', true),
  ('019fa2a1-516d-70ba-858f-704cf877f87a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5131-7642-b999-a3637fd3f1a5', 'select', 'authenticated', '{}', true),
  ('019fa2a1-52cc-7639-8445-8cae6e665c62', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5285-725c-9bcd-65d477e277f4', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-52d0-7229-b2ad-a1305b3ae90f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5285-725c-9bcd-65d477e277f4', 'select', 'authenticated', '{}', true),
  ('019fa2a1-533c-79a4-bea0-8af19c2309ce', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-52e7-7b9a-83c9-44ece4f9c7a4', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-533e-7f79-ba50-75d5cc2144c5', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-52e7-7b9a-83c9-44ece4f9c7a4', 'select', 'authenticated', '{}', true),
  ('019fa2a1-53b3-7dfc-8f44-fa4342246d8b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5378-7160-b636-5d7814a54a7c', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-53b6-73c9-941c-a19ca2d996e9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5378-7160-b636-5d7814a54a7c', 'select', 'authenticated', '{}', true),
  ('019fa2a1-53b8-7a6e-9ea3-e30967daa1d1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5378-7160-b636-5d7814a54a7c', 'update', 'authenticated', '{}', true),
  ('019fa2a1-53bb-71e2-b804-010d13357996', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5378-7160-b636-5d7814a54a7c', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-540c-766d-9d79-1ec9416c598e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-53be-7020-a577-17e52f91740f', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-540e-7c5d-b2e2-bd9be9cc9d6a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-53be-7020-a577-17e52f91740f', 'select', 'authenticated', '{}', true),
  ('019fa2a1-5411-7376-90d1-a1ecb6a43253', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-53be-7020-a577-17e52f91740f', 'update', 'authenticated', '{}', true),
  ('019fa2a1-5413-7bbf-b49c-79d8d9ce93a2', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-53be-7020-a577-17e52f91740f', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-5452-7a63-bd01-0f29f4aa0cee', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5416-73f2-acac-2d0393ddb8cb', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-5455-7360-9450-2e2fad79cc2a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5416-73f2-acac-2d0393ddb8cb', 'select', 'authenticated', '{}', true),
  ('019fa2a1-5644-747e-8f75-2c4b1daecac3', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5607-704a-bacc-b1c2d99357f7', 'select', 'public', '{}', true),
  ('019fa2a1-590a-783c-a9f0-bd999e51fb9e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5131-7642-b999-a3637fd3f1a5', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-590d-7f4b-b9cf-efd1361f7a81', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5131-7642-b999-a3637fd3f1a5', 'update', 'authenticated', '{}', true),
  ('019fa2a1-5911-7170-889e-702d4bd2c19a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5131-7642-b999-a3637fd3f1a5', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-592d-739a-bcea-2a6cad4ffdba', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5182-755b-a123-1190a88df2cf', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-5930-774d-989b-f077025383c3', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5182-755b-a123-1190a88df2cf', 'select', 'authenticated', '{}', true),
  ('019fa2a1-5933-775e-8f0a-e349b038fe48', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5182-755b-a123-1190a88df2cf', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-594a-7ecb-8fd6-88911cb20e54', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51d7-7525-a82f-f18b7765f445', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-594e-70b9-993a-8034d2961932', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51d7-7525-a82f-f18b7765f445', 'select', 'authenticated', '{}', true),
  ('019fa2a1-5951-716c-acca-8ba374bdf6c9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51d7-7525-a82f-f18b7765f445', 'update', 'authenticated', '{}', true),
  ('019fa2a1-5954-71b5-90f4-8cb3a6f4ac68', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51d7-7525-a82f-f18b7765f445', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-59bd-7732-bd5b-1cec51e11613', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5245-7943-99d6-ab69b0046c4a', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-59c0-7a33-9378-df068c5603f8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5245-7943-99d6-ab69b0046c4a', 'select', 'authenticated', '{}', true),
  ('019fa2a1-59c3-7c83-bf61-f3967456636f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5245-7943-99d6-ab69b0046c4a', 'update', 'authenticated', '{}', true),
  ('019fa2a1-59c6-7ef4-b952-83f84f4778ac', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5245-7943-99d6-ab69b0046c4a', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-59e6-7b25-a1a5-9264c4a9fe41', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5468-7986-ba62-d5ec673318b9', 'select', 'authenticated', '{}', true),
  ('019fa2a1-59ef-7a55-aa51-088c83c793aa', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5468-7986-ba62-d5ec673318b9', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-59f4-75d1-a583-feeadbfe1f74', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5468-7986-ba62-d5ec673318b9', 'update', 'authenticated', '{}', true),
  ('019fa2a1-59f8-75ee-9cf1-e8ccdf35eb76', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5468-7986-ba62-d5ec673318b9', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-5a12-7b87-afb7-0560127adf2c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5496-7d14-aea2-866a78236d8a', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-5a15-7d33-9331-da53b59871ac', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5496-7d14-aea2-866a78236d8a', 'select', 'authenticated', '{}', true),
  ('019fa2a1-5a18-7faf-8ffc-12fc6d5d35f6', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5496-7d14-aea2-866a78236d8a', 'update', 'authenticated', '{}', true),
  ('019fa2a1-5a1c-7015-b226-c6cbdd8c32a3', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5496-7d14-aea2-866a78236d8a', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-5a3b-7ed5-a14a-c714ed646858', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-558c-7bc2-b6aa-c20fbc1f8f2a', 'select', 'authenticated', '{}', true),
  ('019fa2a1-5a3f-7215-8a41-56f90da2f6a9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-558c-7bc2-b6aa-c20fbc1f8f2a', 'update', 'authenticated', '{019fa2a1-566e-7aa8-8e31-672f872b7daa,019fa2a1-5662-721e-b5c7-67c67cfab67f,019fa2a1-5685-7e66-9b5b-9a045b2df0df,019fa2a1-567a-7b2f-9223-a495c543dbcd}', true),
  ('019fa2a1-5a5c-75cb-8e8c-6233caece75c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-55cd-7a92-9979-3b8d9bc899b3', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-5a5f-7c34-b9ea-a8286f30e852', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-55cd-7a92-9979-3b8d9bc899b3', 'select', 'authenticated', '{}', true),
  ('019fa2a1-5a63-79a6-9043-73de4387119d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-55cd-7a92-9979-3b8d9bc899b3', 'update', 'authenticated', '{}', true),
  ('019fa2a1-5a67-7055-b02c-d5b3c7493c68', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-55cd-7a92-9979-3b8d9bc899b3', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-5a88-7a0a-855c-8c6d1bfb1357', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-57ac-73c9-bd3e-65e6d7444548', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-5a8b-7c6a-b843-1359e1a42d0a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-57ac-73c9-bd3e-65e6d7444548', 'select', 'authenticated', '{}', true),
  ('019fa2a1-5aa1-7343-8035-5455da189aa8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-56f9-78f0-931f-4812580b70dd', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-5aa4-7be7-8947-4b8d55af2c51', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-56f9-78f0-931f-4812580b70dd', 'select', 'authenticated', '{}', true),
  ('019fa2a1-5ab8-720d-a577-4315cacdfe8d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-574e-737f-9b1f-25f5eb8d9dd6', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-5abb-719c-b811-864e9ccb0cf9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-574e-737f-9b1f-25f5eb8d9dd6', 'select', 'authenticated', '{}', true),
  ('019fa2a1-5acd-71fc-b5e0-bd92200f785c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5813-7ca8-bd2f-4f5cde8b71a6', 'select', 'authenticated', '{}', true),
  ('019fa2a1-5ad0-776f-8019-88fd06c2bdbd', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5813-7ca8-bd2f-4f5cde8b71a6', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-5ad3-78b6-8f65-3a5f641b99f8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5813-7ca8-bd2f-4f5cde8b71a6', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-5ae9-7981-9ff6-f79fef2512c2', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5856-7452-ad3a-45b1f4c4fc67', 'select', 'authenticated', '{}', true),
  ('019fa2a1-5aec-7873-9fae-16279b27c698', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5856-7452-ad3a-45b1f4c4fc67', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-5b69-7cb5-9c97-b4107a48767b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b1d-7b27-bab2-e3c469e536af', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-5b6d-7447-86e1-238e4e5c0ccb', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b1d-7b27-bab2-e3c469e536af', 'update', 'authenticated', '{}', true),
  ('019fa2a1-5b70-75be-a180-3f37e3394384', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b1d-7b27-bab2-e3c469e536af', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-5d84-71e3-ab8c-8b527d7e3b71', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5c8d-7633-a186-023c9c2285e6', 'select', 'authenticated', '{}', true),
  ('019fa2a1-60dc-741e-8c64-235d03536a1a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5d87-7ece-8e60-1ad949ecfb19', 'select', 'authenticated', '{}', true),
  ('019fa2a1-60df-773d-a721-cb075dfc4b50', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5d87-7ece-8e60-1ad949ecfb19', 'update', 'authenticated', '{}', true),
  ('019fa2a1-62d1-7ae1-a8d3-041207965be0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-61d6-7dff-876e-13802d91c7ec', 'select', 'authenticated', '{}', true),
  ('019fa2a1-62d5-7ece-9cdf-e33283df2fb1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-61d6-7dff-876e-13802d91c7ec', 'update', 'authenticated', '{}', true),
  ('019fa2a1-64f8-741f-9249-02a8554b7251', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-643a-7595-bd9e-8c50e40166bc', 'select', 'authenticated', '{}', true),
  ('019fa2a1-64fb-7eba-913f-c005ea2fba3e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-643a-7595-bd9e-8c50e40166bc', 'update', 'authenticated', '{}', true),
  ('019fa2a1-6647-75d2-a30c-35dfaf39ec11', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6514-72da-b9d9-3bdb2c772b8c', 'select', 'authenticated', '{}', true),
  ('019fa2a1-664b-70a6-b698-cf4afba45a1c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6514-72da-b9d9-3bdb2c772b8c', 'update', 'authenticated', '{}', true),
  ('019fa2a1-664e-7da4-bd1e-20d799ccc682', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6514-72da-b9d9-3bdb2c772b8c', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-66dc-7097-af64-268b5a730981', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6661-7502-b1a4-7ebfccb37ee9', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-66e1-7d2a-bd82-e8f434f2bbe1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6661-7502-b1a4-7ebfccb37ee9', 'update', 'authenticated', '{}', true),
  ('019fa2a1-66e5-798d-903a-5843bb4eaf09', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6661-7502-b1a4-7ebfccb37ee9', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-6851-7583-beb3-2e320324766f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-674f-73fa-9633-39edfbd13c6c', 'select', 'authenticated', '{}', true),
  ('019fa2a1-6855-771a-bbd1-903d0c7cdac3', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-674f-73fa-9633-39edfbd13c6c', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-6859-739b-8597-7dc526558711', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-674f-73fa-9633-39edfbd13c6c', 'update', 'authenticated', '{}', true),
  ('019fa2a1-685c-7fad-8e62-f8b3d85c6a2a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-674f-73fa-9633-39edfbd13c6c', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-6a69-723b-9147-f08729696ac4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-69aa-7ba6-a7ef-3303f246936b', 'insert', 'authenticated', '{019fa2a1-69f7-7268-9315-0e1dad55199a,019fa2a1-69d7-7270-8c78-7fb7cca55665,019fa2a1-6a21-7ab9-829c-dfc1268fd190,019fa2a1-6a35-7a5e-bc91-8ba261a95af0}', true),
  ('019fa2a1-6a6d-7890-addb-36ef790ad78f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-69aa-7ba6-a7ef-3303f246936b', 'update', 'authenticated', '{019fa2a1-6a21-7ab9-829c-dfc1268fd190,019fa2a1-6a35-7a5e-bc91-8ba261a95af0}', true),
  ('019fa2a1-6a71-7b89-9aa6-d57e31b0012f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-69aa-7ba6-a7ef-3303f246936b', 'select', 'authenticated', '{}', true),
  ('019fa2a1-6a75-7cd7-a71d-2f79c5989b03', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-69aa-7ba6-a7ef-3303f246936b', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-6b82-7bda-b27c-65b6977ae2ed', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6abc-79b5-a0c3-7f1bb20ebefd', 'insert', 'authenticated', '{019fa2a1-6aff-7391-b9b2-a2f89d1a8c89,019fa2a1-6b11-7429-b302-5db1d23d732e,019fa2a1-6ae2-75a2-a49d-608b8c75952b,019fa2a1-6b36-7a6f-a975-2287195be05b,019fa2a1-6b4b-7542-b9d1-cda664b69eaa}', true),
  ('019fa2a1-6b87-701c-b137-8fdd7c9df99e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6abc-79b5-a0c3-7f1bb20ebefd', 'update', 'authenticated', '{019fa2a1-6b36-7a6f-a975-2287195be05b,019fa2a1-6b4b-7542-b9d1-cda664b69eaa}', true),
  ('019fa2a1-6b8b-73b0-b139-1238a1805702', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6abc-79b5-a0c3-7f1bb20ebefd', 'select', 'authenticated', '{}', true),
  ('019fa2a1-6b8f-7ca9-9edc-b54451f43412', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6abc-79b5-a0c3-7f1bb20ebefd', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-6ce7-7353-8f15-c75d541bf502', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6bd3-7a50-b4af-3c2cb7aee426', 'select', 'authenticated', '{}', true),
  ('019fa2a1-6ceb-7428-9e9e-6e1c7f41da7d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6bd3-7a50-b4af-3c2cb7aee426', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-6cf0-7458-b678-d44ce4ae65d2', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6bd3-7a50-b4af-3c2cb7aee426', 'update', 'authenticated', '{019fa2a1-6c9f-790c-8a39-712f85f92529}', true),
  ('019fa2a1-6dc8-7610-9cdc-8d270cac3cd5', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6d06-750a-9c65-845342800227', 'select', 'authenticated', '{}', true),
  ('019fa2a1-6fa9-7c0a-acab-ee918fc02103', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6e03-77a5-8d95-46056bdd7ccf', 'select', 'authenticated', '{019fa2a1-6e2b-7af1-9ce3-0b69d171b046,019fa2a1-6e3c-7f8f-808a-23da32526375,019fa2a1-6e4d-725d-a8b7-b21d828e48db,019fa2a1-6e5c-7d59-8767-51a01cea9c22}', true),
  ('019fa2a1-6fae-7577-97d9-1daa2bd53c1e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6e03-77a5-8d95-46056bdd7ccf', 'insert', 'authenticated', '{}', true),
  ('019fa2a1-6fb3-7043-9056-018e4841c30f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6e03-77a5-8d95-46056bdd7ccf', 'update', 'authenticated', '{}', true),
  ('019fa2a1-6fb7-77b3-808d-c2707c58cc9e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6e03-77a5-8d95-46056bdd7ccf', 'delete', 'authenticated', '{}', true),
  ('019fa2a1-7157-7080-8090-8ad035447140', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-703c-73a4-bcd4-ef0ed194b005', 'select', 'authenticated', '{}', true),
  ('019fa2a1-74b3-7327-9c0a-98888ff62608', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-72e9-73af-9d7e-46dedcbda5ad', 'select', 'authenticated', '{}', true),
  ('019fa2a1-74c5-71c9-8e95-dba7e94ff9ec', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-73db-7463-ae1b-141b8847e6ed', 'select', 'authenticated', '{}', true),
  ('019fa2a1-75c0-7d51-9962-d8556c5836fe', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-74cf-7e12-bb6b-5a4db46c9efb', 'select', 'authenticated', '{}', true);


SET session_replication_role TO DEFAULT;


