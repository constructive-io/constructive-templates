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
  ('019fa2a1-4fc9-7277-940c-310cf60b9ae1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fb9-782c-a61c-7922a0a61d27', 'administrator'),
  ('019fa2a1-4fce-7c88-a12b-91a3be5809b9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fb9-782c-a61c-7922a0a61d27', 'authenticated'),
  ('019fa2a1-4fd2-7cb4-bc0a-a28bb64c56bc', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fb9-782c-a61c-7922a0a61d27', 'anonymous'),
  ('019fa2a1-4fe7-75e2-a73b-772fdf56a451', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fba-772a-bee5-b9d7472c1874', 'administrator'),
  ('019fa2a1-4fea-7696-ac44-a8bd58fbdd26', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fba-772a-bee5-b9d7472c1874', 'authenticated'),
  ('019fa2a1-4fed-76f0-a5cc-1d8cc304f585', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fba-772a-bee5-b9d7472c1874', 'anonymous'),
  ('019fa2a1-5010-7610-aca7-4c720ea84a8b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', 'administrator'),
  ('019fa2a1-5013-70db-9256-ab91a7be876a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', 'authenticated'),
  ('019fa2a1-5015-79d9-b33e-6668811bc8e5', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', 'anonymous'),
  ('019fa2a1-50ac-7f2c-8555-cb7114203d39', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'administrator'),
  ('019fa2a1-50af-7c7c-820e-8ffa116a2700', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'authenticated'),
  ('019fa2a1-50b2-7793-bbeb-157ea20f0c43', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', 'anonymous'),
  ('019fa2a1-5107-740e-8c5a-1d50611aa037', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', 'administrator'),
  ('019fa2a1-5109-7ec4-806a-d9613f6deee4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', 'authenticated'),
  ('019fa2a1-510c-787c-b309-d7acec1bd733', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', 'anonymous'),
  ('019fa2a1-511c-76d8-8c1d-5df382024d75', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5119-7816-ab77-973ecdcdafa4', 'administrator'),
  ('019fa2a1-511f-70d9-9a0f-3376eb86fd68', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5119-7816-ab77-973ecdcdafa4', 'authenticated'),
  ('019fa2a1-5121-7c2b-a65b-a5ec664557b4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5119-7816-ab77-973ecdcdafa4', 'anonymous'),
  ('019fa2a1-51a6-752e-8621-081d762b06e7', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'administrator'),
  ('019fa2a1-51a9-7958-abb6-60f0acf33d61', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'authenticated'),
  ('019fa2a1-51ac-7d92-9c2f-7e50d445d731', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', 'anonymous'),
  ('019fa2a1-51bf-7693-ae5d-3efcb73e2cdd', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51bb-7c48-a313-feb84675ce8d', 'administrator'),
  ('019fa2a1-51c2-749d-93d5-9a753777147d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51bb-7c48-a313-feb84675ce8d', 'authenticated'),
  ('019fa2a1-51c5-7213-a9d8-8872b47ff144', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51bb-7c48-a313-feb84675ce8d', 'anonymous'),
  ('019fa2a1-5564-7566-8f6c-73b434b47f33', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5560-76ce-bbf2-797a38176260', 'administrator'),
  ('019fa2a1-556a-75dc-a589-084c43c2c8f0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5560-76ce-bbf2-797a38176260', 'authenticated'),
  ('019fa2a1-556e-7c08-ae9d-15a4960ba19e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5560-76ce-bbf2-797a38176260', 'anonymous'),
  ('019fa2a1-5afc-779d-8d71-5ea869f7398a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', 'administrator'),
  ('019fa2a1-5b00-7320-b92f-333f65ab8383', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', 'authenticated'),
  ('019fa2a1-5b04-7f51-aa1f-214f4f8dcf6a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', 'anonymous'),
  ('019fa2a1-5b97-7723-bf68-0fbbc893eeb5', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'administrator'),
  ('019fa2a1-5b9c-7814-8f95-96ac594a5e36', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'authenticated'),
  ('019fa2a1-5ba0-7c1b-a8c3-eaeb26b94b2b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'anonymous'),
  ('019fa2a1-6726-7826-80ab-89c6dc6fb41e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6722-709f-922e-d839fd79c906', 'administrator'),
  ('019fa2a1-672b-775d-949e-8a037af5d83a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6722-709f-922e-d839fd79c906', 'authenticated'),
  ('019fa2a1-6730-7010-827d-d4fc0d20232c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6722-709f-922e-d839fd79c906', 'anonymous'),
  ('019fa2a1-68d7-7d7c-887b-bcce7dd55ba4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'administrator'),
  ('019fa2a1-68dd-70e7-8bf1-ca3d3717af93', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'authenticated'),
  ('019fa2a1-68e2-7798-8235-fd39b7c67fe0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'anonymous'),
  ('019fa2a1-694b-77ab-a887-7d643f433ab3', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'administrator'),
  ('019fa2a1-6950-7b34-8144-a5812de14bc1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'authenticated'),
  ('019fa2a1-6956-76fd-844f-c154d6a6e75f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', 'anonymous'),
  ('019fa2a1-697d-7349-8ab9-637f6c1d223b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6977-72e2-86f0-50e4ac24796a', 'administrator'),
  ('019fa2a1-6982-7e66-85a8-bbc581824cb2', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6977-72e2-86f0-50e4ac24796a', 'authenticated'),
  ('019fa2a1-6988-7151-91d0-7c0c1cf8a80d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6977-72e2-86f0-50e4ac24796a', 'anonymous'),
  ('019fa2a1-7005-7b2e-887b-9aafdfb596c2', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-7000-79ef-8856-c21f21a53591', 'administrator'),
  ('019fa2a1-700b-7848-8943-092838f7311c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-7000-79ef-8856-c21f21a53591', 'authenticated'),
  ('019fa2a1-7011-7da9-a3c3-31312c42f774', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-7000-79ef-8856-c21f21a53591', 'anonymous');


SET session_replication_role TO DEFAULT;


