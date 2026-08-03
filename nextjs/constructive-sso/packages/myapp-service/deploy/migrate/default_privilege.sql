-- Deploy: migrate/default_privilege
-- made with <3 @ constructive.io

-- requires: migrate/trigger_function


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

INSERT INTO metaschema_public.default_privilege (
  id,
  database_id,
  schema_id,
  object_type,
  privilege,
  grantee_name,
  is_grant
) VALUES
  ('019fc104-f2aa-7b62-a6b0-27654432364c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-70c5-a245-14fc6887a0dd', 'tables', 'ALL', 'administrator', true),
  ('019fc104-f2ae-722e-8623-03ddc88cb009', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-70c5-a245-14fc6887a0dd', 'sequences', 'ALL', 'administrator', true),
  ('019fc104-f2af-7f7f-af6f-b559dafc88ba', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-70c5-a245-14fc6887a0dd', 'functions', 'ALL', 'administrator', true),
  ('019fc104-f2b1-7ce6-8b00-2900881e571e', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-70c5-a245-14fc6887a0dd', 'functions', 'ALL', 'authenticated', true),
  ('019fc104-f2b3-7b20-a432-4c1d49a52e8b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-70c5-a245-14fc6887a0dd', 'sequences', 'ALL', 'authenticated', true),
  ('019fc104-f2b5-7604-bffa-f097464d67a7', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-70c5-a245-14fc6887a0dd', 'functions', 'ALL', 'anonymous', true),
  ('019fc104-f2c5-730f-a397-83ed791aa6d2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-7a40-b992-5faed1bc8194', 'tables', 'ALL', 'administrator', true),
  ('019fc104-f2c8-76a2-ae6b-294db6ba444d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-7a40-b992-5faed1bc8194', 'sequences', 'ALL', 'administrator', true),
  ('019fc104-f2ca-72a7-a70c-f6dd70bec775', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-7a40-b992-5faed1bc8194', 'functions', 'ALL', 'administrator', true),
  ('019fc104-f2cc-7158-b02e-dac781db6a4c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-7a40-b992-5faed1bc8194', 'functions', 'ALL', 'authenticated', true),
  ('019fc104-f2ce-726e-a5f9-813acd1e1f97', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-7a40-b992-5faed1bc8194', 'sequences', 'ALL', 'authenticated', true),
  ('019fc104-f2d0-722f-b1b3-a80448beb9ab', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f294-7a40-b992-5faed1bc8194', 'functions', 'ALL', 'anonymous', true),
  ('019fc104-f2e5-7115-a448-07f99f247cd3', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', 'tables', 'ALL', 'administrator', true),
  ('019fc104-f2e8-7394-98c6-af81e09ec753', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', 'sequences', 'ALL', 'administrator', true),
  ('019fc104-f2e9-7bf8-9941-89f78b3cf2ff', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', 'functions', 'ALL', 'administrator', true),
  ('019fc104-f2eb-7d27-994b-5a8af93c8ad8', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', 'functions', 'ALL', 'authenticated', true),
  ('019fc104-f2ed-76ed-a412-0d4ef3809095', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', 'sequences', 'ALL', 'authenticated', true),
  ('019fc104-f2ef-7241-a003-e68a99a31990', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', 'functions', 'ALL', 'anonymous', true),
  ('019fc104-f3a8-76eb-ada6-2e2d998e84b4', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f39c-7300-895c-30b0b61a670e', 'tables', 'ALL', 'administrator', true),
  ('019fc104-f3ab-75cc-8b05-90a607d5254e', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f39c-7300-895c-30b0b61a670e', 'sequences', 'ALL', 'administrator', true),
  ('019fc104-f3ad-7433-ad88-49a09a992a33', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f39c-7300-895c-30b0b61a670e', 'functions', 'ALL', 'administrator', true),
  ('019fc104-f3af-7005-88fa-099a37c3009f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f39c-7300-895c-30b0b61a670e', 'functions', 'ALL', 'authenticated', true),
  ('019fc104-f3b0-77e2-8d3b-9c0a03bb976d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f39c-7300-895c-30b0b61a670e', 'sequences', 'ALL', 'authenticated', true),
  ('019fc104-f3b1-7fb2-9d27-f2c608de96b7', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f39c-7300-895c-30b0b61a670e', 'functions', 'ALL', 'anonymous', true),
  ('019fc104-f405-7d69-9319-12f2f4c3749a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f3fb-7199-84be-973cb5027963', 'tables', 'ALL', 'administrator', true),
  ('019fc104-f408-74a4-84a2-d82ad4217740', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f3fb-7199-84be-973cb5027963', 'sequences', 'ALL', 'administrator', true),
  ('019fc104-f409-7efa-9f0c-438d7b2a7af6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f3fb-7199-84be-973cb5027963', 'functions', 'ALL', 'administrator', true),
  ('019fc104-f40b-7bd7-8226-9b4f037fb1f2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f3fb-7199-84be-973cb5027963', 'functions', 'ALL', 'authenticated', true),
  ('019fc104-f40d-76f1-a3da-7259abd17ddd', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f3fb-7199-84be-973cb5027963', 'sequences', 'ALL', 'authenticated', true),
  ('019fc104-f40e-7fc1-a03b-627ff761cb87', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f3fb-7199-84be-973cb5027963', 'functions', 'ALL', 'anonymous', true),
  ('019fc104-f41c-7c20-a01e-b32ac944dc63', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f410-7e31-8f42-b46383f39596', 'tables', 'ALL', 'administrator', true),
  ('019fc104-f41f-7574-9ed8-6b17b40fb441', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f410-7e31-8f42-b46383f39596', 'sequences', 'ALL', 'administrator', true),
  ('019fc104-f421-70cb-9adb-fa43a536334e', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f410-7e31-8f42-b46383f39596', 'functions', 'ALL', 'administrator', true),
  ('019fc104-f422-7b2c-b70d-e7646131529f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f410-7e31-8f42-b46383f39596', 'functions', 'ALL', 'authenticated', true),
  ('019fc104-f424-74ca-af07-4dad1a0a1fd7', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f410-7e31-8f42-b46383f39596', 'sequences', 'ALL', 'authenticated', true),
  ('019fc104-f425-7e10-a782-3d72f8a370f3', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f410-7e31-8f42-b46383f39596', 'functions', 'ALL', 'anonymous', true),
  ('019fc104-f4b6-711e-9620-c77b325711cc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4a9-7dad-b8d1-37fc33a66117', 'tables', 'ALL', 'administrator', true),
  ('019fc104-f4b8-79c0-ad26-20a3b3744f00', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4a9-7dad-b8d1-37fc33a66117', 'sequences', 'ALL', 'administrator', true),
  ('019fc104-f4ba-76c2-a738-653bd82f6b1b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4a9-7dad-b8d1-37fc33a66117', 'functions', 'ALL', 'administrator', true),
  ('019fc104-f4bc-73ac-bc58-9d0a6ea2e3c6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4a9-7dad-b8d1-37fc33a66117', 'functions', 'ALL', 'authenticated', true),
  ('019fc104-f4bd-7f1f-b820-a77347b4f1a2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4a9-7dad-b8d1-37fc33a66117', 'sequences', 'ALL', 'authenticated', true),
  ('019fc104-f4bf-7a3e-9d7b-eab48dc5e6c4', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4a9-7dad-b8d1-37fc33a66117', 'functions', 'ALL', 'anonymous', true),
  ('019fc104-f4cf-7983-a640-27070b36c0e3', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4c1-7d26-9e70-bc3cc5757a99', 'tables', 'ALL', 'administrator', true),
  ('019fc104-f4d2-7eb8-b4e6-1d140e08d399', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4c1-7d26-9e70-bc3cc5757a99', 'sequences', 'ALL', 'administrator', true),
  ('019fc104-f4d5-726e-b4b9-b1acf03811f8', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4c1-7d26-9e70-bc3cc5757a99', 'functions', 'ALL', 'administrator', true),
  ('019fc104-f4d7-71b6-ad74-22f555525d0e', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4c1-7d26-9e70-bc3cc5757a99', 'functions', 'ALL', 'authenticated', true),
  ('019fc104-f4d8-7da8-821b-bacaeb33cf68', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4c1-7d26-9e70-bc3cc5757a99', 'sequences', 'ALL', 'authenticated', true),
  ('019fc104-f4da-7837-9720-89ecb5e6b39c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f4c1-7d26-9e70-bc3cc5757a99', 'functions', 'ALL', 'anonymous', true),
  ('019fc104-f8b7-7adf-afff-92ee02e51154', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8a8-7507-a922-39132d5dfbe9', 'tables', 'ALL', 'administrator', true),
  ('019fc104-f8ba-7abb-adf1-aa67d80d03f0', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8a8-7507-a922-39132d5dfbe9', 'sequences', 'ALL', 'administrator', true),
  ('019fc104-f8bd-722c-8313-1972d2a7e94f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8a8-7507-a922-39132d5dfbe9', 'functions', 'ALL', 'administrator', true),
  ('019fc104-f8bf-73d7-9674-5d5e47611703', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8a8-7507-a922-39132d5dfbe9', 'functions', 'ALL', 'authenticated', true),
  ('019fc104-f8c1-78d8-a816-fb3f14a5bb1e', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8a8-7507-a922-39132d5dfbe9', 'sequences', 'ALL', 'authenticated', true),
  ('019fc104-f8c3-7d29-b2b6-21375bd4bb19', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f8a8-7507-a922-39132d5dfbe9', 'functions', 'ALL', 'anonymous', true),
  ('019fc104-fe5d-776c-8cd1-0af1e2a4df05', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', 'tables', 'ALL', 'administrator', true),
  ('019fc104-fe60-7c44-adf6-6387f64cdf9c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', 'sequences', 'ALL', 'administrator', true),
  ('019fc104-fe63-729d-a478-b807ade31b3f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', 'functions', 'ALL', 'administrator', true),
  ('019fc104-fe65-7b9a-8864-95d4dea188cc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', 'functions', 'ALL', 'authenticated', true),
  ('019fc104-fe67-7f6e-870e-c2a88c84afc2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', 'sequences', 'ALL', 'authenticated', true),
  ('019fc104-fe6a-7788-83ca-d293e0de49cc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fe4d-756f-a748-ecfa3f8cb05b', 'functions', 'ALL', 'anonymous', true),
  ('019fc104-fef3-7106-a344-b16a52d1b33f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', 'tables', 'ALL', 'administrator', true),
  ('019fc104-fef6-778d-8035-3226eac8f4a2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', 'sequences', 'ALL', 'administrator', true),
  ('019fc104-fef9-7318-8e10-d294da5d2b5c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', 'functions', 'ALL', 'administrator', true),
  ('019fc104-fefb-7936-b912-e3bf6a9a4f3b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', 'functions', 'ALL', 'authenticated', true),
  ('019fc104-fefd-7e2d-9d02-b240d2e624ae', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', 'sequences', 'ALL', 'authenticated', true),
  ('019fc104-ff00-72cc-a7c9-931ef3cbb259', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', 'functions', 'ALL', 'anonymous', true),
  ('019fc105-0a71-7a59-a970-2af90678033d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a5d-726d-81e3-16720f03bcfa', 'tables', 'ALL', 'administrator', true),
  ('019fc105-0a76-73bd-9878-e3141caedb30', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a5d-726d-81e3-16720f03bcfa', 'sequences', 'ALL', 'administrator', true),
  ('019fc105-0a79-758e-9d11-cf449a1ddb11', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a5d-726d-81e3-16720f03bcfa', 'functions', 'ALL', 'administrator', true),
  ('019fc105-0a7c-7f21-98f1-115a757ed891', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a5d-726d-81e3-16720f03bcfa', 'functions', 'ALL', 'authenticated', true),
  ('019fc105-0a80-700c-aa78-0806ed73c4d8', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a5d-726d-81e3-16720f03bcfa', 'sequences', 'ALL', 'authenticated', true),
  ('019fc105-0a83-79f3-bdc2-1785936afcab', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0a5d-726d-81e3-16720f03bcfa', 'functions', 'ALL', 'anonymous', true),
  ('019fc105-0c33-77f1-adc7-ca1f2da21dcc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', 'tables', 'ALL', 'administrator', true),
  ('019fc105-0c38-7426-b752-913df1a43004', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', 'sequences', 'ALL', 'administrator', true),
  ('019fc105-0c3b-7815-bd8d-cf3bb6efe9de', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', 'functions', 'ALL', 'administrator', true),
  ('019fc105-0c3f-7490-be40-1ebf431b2838', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', 'functions', 'ALL', 'authenticated', true),
  ('019fc105-0c42-78b9-b7ea-005ddef556e3', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', 'sequences', 'ALL', 'authenticated', true),
  ('019fc105-0c46-7436-9821-d89e2e8395cc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', 'functions', 'ALL', 'anonymous', true),
  ('019fc105-0ca4-7287-a482-dfff919aad01', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', 'tables', 'ALL', 'administrator', true),
  ('019fc105-0ca9-72a7-9169-2653f7ce09b4', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', 'sequences', 'ALL', 'administrator', true),
  ('019fc105-0cad-728c-8f45-5bd89ddace17', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', 'functions', 'ALL', 'administrator', true),
  ('019fc105-0cb0-78d5-8049-7a6f00bdf29c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', 'functions', 'ALL', 'authenticated', true),
  ('019fc105-0cb3-7e4f-bfac-e1439c44b413', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', 'sequences', 'ALL', 'authenticated', true),
  ('019fc105-0cb7-7333-a13f-26d6c86994cf', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', 'functions', 'ALL', 'anonymous', true),
  ('019fc105-0cd5-7d96-b0bf-874127e6e3c2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cbe-7083-b3b1-f8ed102c2bb0', 'tables', 'ALL', 'administrator', true),
  ('019fc105-0cda-717a-b225-9b03c18382ec', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cbe-7083-b3b1-f8ed102c2bb0', 'sequences', 'ALL', 'administrator', true),
  ('019fc105-0cde-7000-9eb3-f8cfa4aa50f6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cbe-7083-b3b1-f8ed102c2bb0', 'functions', 'ALL', 'administrator', true),
  ('019fc105-0ce4-71c6-a5af-cdeaedfeea78', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cbe-7083-b3b1-f8ed102c2bb0', 'functions', 'ALL', 'authenticated', true),
  ('019fc105-0ce7-7ab4-a242-d6e0bac0bef3', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cbe-7083-b3b1-f8ed102c2bb0', 'sequences', 'ALL', 'authenticated', true),
  ('019fc105-0ceb-7b50-aba8-7d9ab2280646', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0cbe-7083-b3b1-f8ed102c2bb0', 'functions', 'ALL', 'anonymous', true),
  ('019fc105-139d-7780-a2bf-a6fced090b78', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1384-729e-90a7-7b2eadef8142', 'tables', 'ALL', 'administrator', true),
  ('019fc105-13a2-7480-9f66-2cb054297670', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1384-729e-90a7-7b2eadef8142', 'sequences', 'ALL', 'administrator', true),
  ('019fc105-13a5-7fce-b2e8-71dcc8aa019a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1384-729e-90a7-7b2eadef8142', 'functions', 'ALL', 'administrator', true),
  ('019fc105-13aa-75e5-a987-8027a9fa2ec7', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1384-729e-90a7-7b2eadef8142', 'functions', 'ALL', 'authenticated', true),
  ('019fc105-13ae-765a-a96a-3ca607d00837', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1384-729e-90a7-7b2eadef8142', 'sequences', 'ALL', 'authenticated', true),
  ('019fc105-13b2-790f-b620-c966bfa3ce9a', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-1384-729e-90a7-7b2eadef8142', 'functions', 'ALL', 'anonymous', true);


SET session_replication_role TO DEFAULT;


