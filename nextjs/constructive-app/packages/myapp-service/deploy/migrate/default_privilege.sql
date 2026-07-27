-- Deploy: migrate/default_privilege
-- made with <3 @ constructive.io

-- requires: migrate/sites


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
  ('019fa2a1-4fd7-72db-8147-9eb28375fbfb', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fb9-782c-a61c-7922a0a61d27', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-4fda-7ed0-a74a-1cc965b4f282', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fb9-782c-a61c-7922a0a61d27', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-4fdd-71a2-bf39-9d4c8d1c7ede', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fb9-782c-a61c-7922a0a61d27', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-4fdf-722f-a20c-2d2337f081ae', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fb9-782c-a61c-7922a0a61d27', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-4fe0-7d43-afe1-14b156e31232', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fb9-782c-a61c-7922a0a61d27', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-4fe2-782c-a94d-d7539d8ad495', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fb9-782c-a61c-7922a0a61d27', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-4ff0-7911-972b-0c06eeab07fb', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fba-772a-bee5-b9d7472c1874', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-4ff3-7582-9507-5015ec97b0a7', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fba-772a-bee5-b9d7472c1874', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-4ff4-7e71-93c6-d49f29857d2e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fba-772a-bee5-b9d7472c1874', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-4ff6-76ee-847f-853b3b301e1c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fba-772a-bee5-b9d7472c1874', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-4ff7-7ebb-b216-d51bd3d875a4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fba-772a-bee5-b9d7472c1874', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-4ff9-76cf-a1b3-83cb55bfce73', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fba-772a-bee5-b9d7472c1874', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-5018-736e-beaa-feb23a20665e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-501a-74b3-8ca3-0a8eba29e280', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-501b-7ec8-86ff-48b3c8cdf079', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-501d-77ff-be85-bdcdd8e98486', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-501e-7e46-8e06-88fbda6c7b2f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-5020-73c8-911c-6dc22697824d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-50b5-747e-9ae8-dffd47fa75fe', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-50b7-7d24-a3ce-cae836b755ad', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-50b9-773d-9544-042aae4cd59c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-50ba-7f73-bab0-7313d75f78ac', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-50bc-7748-ac48-167fb468b385', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-50bd-7e66-b1a8-3bf1df5006da', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-510f-76d8-8ea8-8295feb6b23f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-5111-7bd2-8dcc-8d1409f4a0ae', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-5113-73f0-800b-d805e4ed831d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-5114-7ce5-9f9f-7f7e9dd36d26', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-5116-73ec-898c-3af1d2dfdf3d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-5117-7b86-8488-74c577590028', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-5124-7a14-9ccf-8d7719e2e59f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5119-7816-ab77-973ecdcdafa4', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-5126-7e79-8157-194c5b414e06', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5119-7816-ab77-973ecdcdafa4', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-5128-7b0a-b4cc-cdcf21fea742', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5119-7816-ab77-973ecdcdafa4', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-512a-7320-bab6-e32bb289545c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5119-7816-ab77-973ecdcdafa4', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-512b-7ac1-881f-40f2eb9d906d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5119-7816-ab77-973ecdcdafa4', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-512d-73ba-92c3-19b2f667cd7c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5119-7816-ab77-973ecdcdafa4', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-51b0-70bf-9bc4-abb25e53ece2', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-51b2-7902-8336-2656ccd11a45', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-51b4-73f3-96f9-f139fe2df4e5', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-51b6-73df-8337-d25aca67aa75', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-51b7-7e40-9c01-51e65c2678f8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-51b9-7947-ac76-d37a4308aae5', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-51c8-78ef-bf03-62bbe69fa816', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51bb-7c48-a313-feb84675ce8d', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-51cb-718b-bb96-0cc12696b14c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51bb-7c48-a313-feb84675ce8d', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-51cc-7bfe-b7ce-49ca1bdcde8e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51bb-7c48-a313-feb84675ce8d', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-51ce-77bc-8ae4-35bd86904f5b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51bb-7c48-a313-feb84675ce8d', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-51d0-727e-b863-90454e8ce20f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51bb-7c48-a313-feb84675ce8d', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-51d1-7cfc-a041-90e1904fbe9b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51bb-7c48-a313-feb84675ce8d', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-5573-7827-a691-0e2728aa69eb', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5560-76ce-bbf2-797a38176260', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-5576-798f-9ffc-ae9a31869751', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5560-76ce-bbf2-797a38176260', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-5578-7d36-997b-829c5d48984d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5560-76ce-bbf2-797a38176260', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-557a-7eb3-9e0a-0e752286cbda', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5560-76ce-bbf2-797a38176260', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-557d-776b-b27e-252b1549cae3', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5560-76ce-bbf2-797a38176260', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-557f-7ae0-ad9b-07d2ba73a071', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5560-76ce-bbf2-797a38176260', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-5b0a-7648-b43e-4716fffef420', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-5b0e-7141-a541-1d17cd6d4b98', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-5b10-7cd9-a011-07d7900cde71', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-5b13-77ac-87e1-3cda48965f58', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-5b16-7bb2-8b3c-5525eef57560', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-5b19-7718-b06f-96c910f45aa7', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-5ba7-7f22-9745-aa7caa048882', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-5bac-747e-b073-3a4d99b14c1c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-5baf-7119-910f-88cb99f0ed79', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-5bb2-7184-ba6d-c298fe7c53ad', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-5bb4-7e1e-96cf-0f7f77834188', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-5bb7-7ce5-bf59-8d2474be7afc', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-6736-756e-a27f-a7aebcf54198', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6722-709f-922e-d839fd79c906', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-673a-73b2-b7e1-c4de73f84d4f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6722-709f-922e-d839fd79c906', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-673d-73e9-801c-bbf90e7ee5cd', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6722-709f-922e-d839fd79c906', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-6740-7352-a594-8738dd101439', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6722-709f-922e-d839fd79c906', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-6743-789e-ae80-7e58b22e2a42', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6722-709f-922e-d839fd79c906', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-6746-7902-8858-99b64d9503c5', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6722-709f-922e-d839fd79c906', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-68e9-73e7-838a-3b2d3cbd41b4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-68ed-7672-bce9-8fc64e3f97d9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-68f1-71ce-95da-3361e8b54f9e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-68f4-7ad0-876f-dc2abdda0e8b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-68f8-7371-a5d6-dc32ecac9e91', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-68fb-752f-85e6-cdd24cb9b1ab', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-695d-73de-bf34-0f4ef378ea54', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-6962-7298-a683-c3a1413b861c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-6966-7110-b808-40d96ea04ab0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-6969-797c-94e7-67f413c12a22', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-696d-75d9-8992-131c2a85c40f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-6970-7a30-b002-24fcef822736', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-698e-7fc3-a507-87d3bb709537', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6977-72e2-86f0-50e4ac24796a', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-6993-72c8-a79d-89e1e093709b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6977-72e2-86f0-50e4ac24796a', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-6996-76b6-bd32-ce4f3ed760ee', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6977-72e2-86f0-50e4ac24796a', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-699a-7122-82ff-5f1cd864c495', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6977-72e2-86f0-50e4ac24796a', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-699d-7ab6-8427-9d259aba4356', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6977-72e2-86f0-50e4ac24796a', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-69a1-74e5-9730-1baff4b58b1e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6977-72e2-86f0-50e4ac24796a', 'functions', 'ALL', 'anonymous', true),
  ('019fa2a1-7019-7505-946a-9ba7f01569d4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-7000-79ef-8856-c21f21a53591', 'tables', 'ALL', 'administrator', true),
  ('019fa2a1-701e-78ed-aab2-147236d3758b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-7000-79ef-8856-c21f21a53591', 'sequences', 'ALL', 'administrator', true),
  ('019fa2a1-7022-7b03-922f-4b358f0155b2', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-7000-79ef-8856-c21f21a53591', 'functions', 'ALL', 'administrator', true),
  ('019fa2a1-7027-726e-bd61-2a12e76c30cb', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-7000-79ef-8856-c21f21a53591', 'functions', 'ALL', 'authenticated', true),
  ('019fa2a1-702a-7c40-895c-6098bc529ab5', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-7000-79ef-8856-c21f21a53591', 'sequences', 'ALL', 'authenticated', true),
  ('019fa2a1-702e-7962-843d-fcbfa7256990', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-7000-79ef-8856-c21f21a53591', 'functions', 'ALL', 'anonymous', true);


SET session_replication_role TO DEFAULT;


