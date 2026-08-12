-- Deploy: migrate/schema_grant
-- made with <3 @ constructive.io

-- requires: migrate/function


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

INSERT INTO metaschema_public.schema_grant (
  id,
  database_id,
  schema_id,
  grantee_name
) VALUES
  ('019fc104-f29f-7207-93dd-e2d50c13b9b0', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-70c5-a245-14fc6887a0dd', 'administrator'),
  ('019fc104-f2a3-7b78-9a20-617ebed6c366', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-70c5-a245-14fc6887a0dd', 'authenticated'),
  ('019fc104-f2a7-705a-bcb4-197219e232da', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-70c5-a245-14fc6887a0dd', 'anonymous'),
  ('019fc104-f2ba-7c3e-ac3a-b2f62d25ab47', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-7a40-b992-5faed1bc8194', 'administrator'),
  ('019fc104-f2be-76da-8e4f-da9f0d50ffad', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-7a40-b992-5faed1bc8194', 'authenticated'),
  ('019fc104-f2c1-7cde-b157-88944549bb97', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-7a40-b992-5faed1bc8194', 'anonymous'),
  ('019fc104-f2d9-76fa-a85c-18d1361bb97a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', 'administrator'),
  ('019fc104-f2dc-7fdd-9a0b-d462a005e564', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', 'authenticated'),
  ('019fc104-f2e0-7b87-a23f-8a024ff3b0f6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', 'anonymous'),
  ('019fc104-f39e-78d1-9bcf-f32bbadb66f7', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f39c-7300-895c-30b0b61a670e', 'administrator'),
  ('019fc104-f3a1-7e36-a18c-37d8c2e19dbe', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f39c-7300-895c-30b0b61a670e', 'authenticated'),
  ('019fc104-f3a5-7205-b1d2-dadb8c1aa092', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f39c-7300-895c-30b0b61a670e', 'anonymous'),
  ('019fc104-f3fd-7284-9110-882f421728f6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f3fb-7199-84be-973cb5027963', 'administrator'),
  ('019fc104-f400-70a2-a4c7-dfa48099f55f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f3fb-7199-84be-973cb5027963', 'authenticated'),
  ('019fc104-f402-7e5f-8da6-fa2dc143e111', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f3fb-7199-84be-973cb5027963', 'anonymous'),
  ('019fc104-f414-7286-9880-7df2c53b053a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f410-7e31-8f42-b46383f39596', 'administrator'),
  ('019fc104-f416-7e25-b93c-bfa8eaeb44d3', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f410-7e31-8f42-b46383f39596', 'authenticated'),
  ('019fc104-f419-7ac7-8722-1b5a07668158', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f410-7e31-8f42-b46383f39596', 'anonymous'),
  ('019fc104-f4ac-7363-8df1-ed6dd2274c6c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4a9-7dad-b8d1-37fc33a66117', 'administrator'),
  ('019fc104-f4af-76f0-9ac3-59f4a90fbf87', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4a9-7dad-b8d1-37fc33a66117', 'authenticated'),
  ('019fc104-f4b2-7cd2-a9da-34ce03aa8584', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4a9-7dad-b8d1-37fc33a66117', 'anonymous'),
  ('019fc104-f4c5-74f2-bf8d-c3c46acd350b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4c1-7d26-9e70-bc3cc5757a99', 'administrator'),
  ('019fc104-f4c8-74ea-89b9-6dad7c654acc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4c1-7d26-9e70-bc3cc5757a99', 'authenticated'),
  ('019fc104-f4cb-7636-8615-74a200583019', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4c1-7d26-9e70-bc3cc5757a99', 'anonymous'),
  ('019fc104-f8ab-79b6-b957-378d27ba2c3b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8a8-7507-a922-39132d5dfbe9', 'administrator'),
  ('019fc104-f8af-7b7e-8e76-333f9074b500', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8a8-7507-a922-39132d5dfbe9', 'authenticated'),
  ('019fc104-f8b3-76c7-94e4-12a6e2980382', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8a8-7507-a922-39132d5dfbe9', 'anonymous'),
  ('019fc104-fe50-7c59-842b-bba2d99f9c25', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', 'administrator'),
  ('019fc104-fe54-7e2c-b9d6-20763bf7e3e6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', 'authenticated'),
  ('019fc104-fe58-79dd-8223-0cb049a2dd60', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', 'anonymous'),
  ('019fc104-fee5-7f9c-b6d3-1f81ca76d879', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', 'administrator'),
  ('019fc104-feea-7448-989f-b7eb31734bb3', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', 'authenticated'),
  ('019fc104-feee-713e-9e07-96febe32fee4', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', 'anonymous'),
  ('019fc105-0a61-7af4-891c-55274c126782', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a5d-726d-81e3-16720f03bcfa', 'administrator'),
  ('019fc105-0a66-73aa-a42a-800be4e66cf0', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a5d-726d-81e3-16720f03bcfa', 'authenticated'),
  ('019fc105-0a6b-70e6-afaa-4dada6826ebc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a5d-726d-81e3-16720f03bcfa', 'anonymous'),
  ('019fc105-0c21-7ffc-a8fd-ed466acf5d18', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', 'administrator'),
  ('019fc105-0c27-7516-b6bb-9db264dbf978', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', 'authenticated'),
  ('019fc105-0c2c-7c8d-951e-2fa3f109ed05', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', 'anonymous'),
  ('019fc105-0c92-75a3-9a36-2637cf077975', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', 'administrator'),
  ('019fc105-0c98-7093-8209-a9f3a6409177', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', 'authenticated'),
  ('019fc105-0c9d-77ea-9f2a-6bfa96324fd9', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', 'anonymous'),
  ('019fc105-0cc4-7005-bf0c-311daedcbef7', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cbe-7083-b3b1-f8ed102c2bb0', 'administrator'),
  ('019fc105-0cc9-75c4-97e8-62255feca79d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cbe-7083-b3b1-f8ed102c2bb0', 'authenticated'),
  ('019fc105-0cce-7a33-bb9f-3e44ca7dda94', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cbe-7083-b3b1-f8ed102c2bb0', 'anonymous'),
  ('019fc105-1389-7824-be96-c4e1e8f89602', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1384-729e-90a7-7b2eadef8142', 'administrator'),
  ('019fc105-138f-75cd-9757-b5a04225e9a1', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1384-729e-90a7-7b2eadef8142', 'authenticated'),
  ('019fc105-1395-7702-9b7c-a3784a456d0f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1384-729e-90a7-7b2eadef8142', 'anonymous');


SET session_replication_role TO DEFAULT;


