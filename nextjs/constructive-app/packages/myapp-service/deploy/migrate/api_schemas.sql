-- Deploy: migrate/api_schemas
-- made with <3 @ constructive.io

-- requires: migrate/api_modules


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

INSERT INTO services_public.api_schemas (
  id,
  database_id,
  schema_id,
  api_id
) VALUES
  ('019fa2a1-5003-73a2-b2c5-83160d827526', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-4fb9-782c-a61c-7922a0a61d27', '019fa2a1-5002-75ec-833a-651fda3d74d6'),
  ('019fa2a1-5021-7ff7-badd-8db8635f360f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', '019fa2a1-5002-72ae-930b-fa3c13f980d4'),
  ('019fa2a1-512f-7184-92b0-15dc68c56d66', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', '019fa2a1-5001-790c-8dfa-3347bd8f781b'),
  ('019fa2a1-51d4-71b8-86ff-3a0252cdfc11', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', '019fa2a1-5002-78dc-aba5-6416d5eb3aa1'),
  ('019fa2a1-5583-7242-b811-20e0cc2eb90d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', '019fa2a1-5001-790c-8dfa-3347bd8f781b'),
  ('019fa2a1-674d-7f3e-af53-1d748abd0250', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6722-709f-922e-d839fd79c906', '019fa2a1-674d-7187-a86f-9ebcb7cdc736'),
  ('019fa2a1-6901-7c59-ba22-6dd93ddd64e1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', '019fa2a1-5002-72ae-930b-fa3c13f980d4'),
  ('019fa2a1-69a8-73aa-b2a5-5c1520d62c6b', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', '019fa2a1-5002-72ae-930b-fa3c13f980d4'),
  ('019fa2a1-7036-7d6a-a264-0d65f1cacc4e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-7000-79ef-8856-c21f21a53591', '019fa2a1-5002-72ae-930b-fa3c13f980d4'),
  ('019fa2a1-b7b2-7847-bb17-11fa79e3c0b8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', '019fa2a1-5002-75ec-833a-651fda3d74d6'),
  ('019fa2a1-b85e-784b-bdee-961da9449289', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-50aa-7d8f-841d-7965af0951a1', '019fa2a1-5002-75ec-833a-651fda3d74d6'),
  ('019fa2a1-b8ef-75c6-8f39-b410b3f01ef7', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5105-75da-89c6-6d24ad9cdf16', '019fa2a1-5002-75ec-833a-651fda3d74d6'),
  ('019fa2a1-b976-79c8-a233-fe1a06e274dc', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-51a3-7e09-92ab-08da59fa62d6', '019fa2a1-5002-75ec-833a-651fda3d74d6'),
  ('019fa2a1-ba0d-7bce-ab3a-a3e49b946a15', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6722-709f-922e-d839fd79c906', '019fa2a1-5002-75ec-833a-651fda3d74d6'),
  ('019fa2a1-ba0e-7962-a50f-07624e5585d4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', '019fa2a1-5002-75ec-833a-651fda3d74d6'),
  ('019fa2a1-ba17-791d-b154-d25ae6276f84', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6946-7910-96e2-15c6e11fd525', '019fa2a1-5002-75ec-833a-651fda3d74d6'),
  ('019fa2a1-ba20-7b84-83ed-2625c903a03f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-7000-79ef-8856-c21f21a53591', '019fa2a1-5002-75ec-833a-651fda3d74d6'),
  ('019fa2a1-ba51-71aa-8a1b-3da1717f796c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'fc04bdf6-abfa-55c6-74eb-4f765f024f7a', '019fa2a1-762f-7b91-aeb4-b40200a7b932');


SET session_replication_role TO DEFAULT;


