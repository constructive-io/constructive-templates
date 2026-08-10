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
  ('019feb75-785d-75b0-9dad-0d878013e714', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784c-7932-a3b6-33342f1bff0c', 'administrator'),
  ('019feb75-7867-71fc-b512-7b4b168caaa3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784c-7932-a3b6-33342f1bff0c', 'authenticated'),
  ('019feb75-786f-7bfb-90a8-7ab4699c360f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784c-7932-a3b6-33342f1bff0c', 'anonymous'),
  ('019feb75-789f-7c0e-9ce3-105b0a435ec4', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784d-7576-93a4-c922966ef5da', 'administrator'),
  ('019feb75-78a7-7890-88d8-9da75f326dc0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784d-7576-93a4-c922966ef5da', 'authenticated'),
  ('019feb75-78ae-7d79-a5b7-ce6c3a18fc55', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784d-7576-93a4-c922966ef5da', 'anonymous'),
  ('019feb75-78d8-7ebc-900a-fa30de521cfe', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78d6-7cd0-9533-31bd8de066b8', 'administrator'),
  ('019feb75-78da-7360-b9be-0316e2f0cdfc', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78d6-7cd0-9533-31bd8de066b8', 'authenticated'),
  ('019feb75-78db-75d5-a4dd-18c3fbe1d5a0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78d6-7cd0-9533-31bd8de066b8', 'anonymous'),
  ('019feb75-7939-76a0-ad98-fe7ab4ed8fee', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7938-77e1-8f66-717a7e6e05de', 'administrator'),
  ('019feb75-793b-7027-b2e9-38689f4d593d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7938-77e1-8f66-717a7e6e05de', 'authenticated'),
  ('019feb75-793c-748d-bfd0-17a7f009593c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7938-77e1-8f66-717a7e6e05de', 'anonymous'),
  ('019feb75-7969-7e5a-a0d8-8a942ec228ac', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7969-7069-ae1a-42277e7befea', 'administrator'),
  ('019feb75-796b-763d-931d-03751743e97f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7969-7069-ae1a-42277e7befea', 'authenticated'),
  ('019feb75-796c-79f9-b05b-f88c3dfc7a32', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7969-7069-ae1a-42277e7befea', 'anonymous'),
  ('019feb75-7972-7ca6-8e44-9af841aecc34', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7970-7957-8ea7-b79d4615b62c', 'administrator'),
  ('019feb75-7974-70e3-8560-3b9881e65381', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7970-7957-8ea7-b79d4615b62c', 'authenticated'),
  ('019feb75-7975-7397-8879-ba961c1fd607', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7970-7957-8ea7-b79d4615b62c', 'anonymous'),
  ('019feb75-79b5-7129-b1ca-d96347419984', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79b4-722d-bbc4-c5ef8a53db6b', 'administrator'),
  ('019feb75-79b6-7909-9d3f-8180afa7b8c2', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79b4-722d-bbc4-c5ef8a53db6b', 'authenticated'),
  ('019feb75-79b7-7e5d-8285-67063b1a6e66', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79b4-722d-bbc4-c5ef8a53db6b', 'anonymous'),
  ('019feb75-79be-7648-b0a5-eb934452d44b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79bc-73be-9da4-a0da9c33a7fc', 'administrator'),
  ('019feb75-79bf-7abb-ad65-ebbf6cff0283', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79bc-73be-9da4-a0da9c33a7fc', 'authenticated'),
  ('019feb75-79c0-7dc7-bab8-eb4464aba3a3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79bc-73be-9da4-a0da9c33a7fc', 'anonymous'),
  ('019feb75-7b5d-736b-b77e-982327c10129', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b5c-710b-a201-95a6bb0962be', 'administrator'),
  ('019feb75-7b5e-7ed2-860a-4f175b61d19a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b5c-710b-a201-95a6bb0962be', 'authenticated'),
  ('019feb75-7b60-73d5-b1c3-b162274b4141', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b5c-710b-a201-95a6bb0962be', 'anonymous'),
  ('019feb75-7ca4-787a-ae8b-08d3e54edac5', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ca3-764e-895e-58b77d9a5f1d', 'administrator'),
  ('019feb75-7ca6-77cd-8f12-c1059720a689', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ca3-764e-895e-58b77d9a5f1d', 'authenticated'),
  ('019feb75-7ca7-7fa8-bbe5-a109d31aae08', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ca3-764e-895e-58b77d9a5f1d', 'anonymous'),
  ('019feb75-7caf-7363-ab4d-aee9fba09f88', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cac-7b80-82dd-d18a956a7fdc', 'administrator'),
  ('019feb75-7cb0-7a54-b252-dfe23c0fc514', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cac-7b80-82dd-d18a956a7fdc', 'authenticated'),
  ('019feb75-7cb2-7326-8e70-e95696df215b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cac-7b80-82dd-d18a956a7fdc', 'anonymous'),
  ('019feb75-8659-7ae2-a908-22bb114f6e96', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8658-74d1-9931-76da2692e55d', 'administrator'),
  ('019feb75-865b-78b7-8b28-9daefeb0d3ca', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8658-74d1-9931-76da2692e55d', 'authenticated'),
  ('019feb75-865c-7fd1-9902-c49084a27b7f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8658-74d1-9931-76da2692e55d', 'anonymous'),
  ('019feb75-8697-72d6-b081-597fd1f96a58', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', 'administrator'),
  ('019feb75-8699-707f-be70-4b115066d6f6', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', 'authenticated'),
  ('019feb75-869a-76b4-80d8-d1f01b39b187', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', 'anonymous'),
  ('019feb75-895d-720d-9044-06694f5bcddd', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-895b-7b97-b98f-01b51196320f', 'administrator'),
  ('019feb75-895f-70a1-b863-b20687f2ec77', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-895b-7b97-b98f-01b51196320f', 'authenticated'),
  ('019feb75-8960-796d-b726-948fb70c2e2f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-895b-7b97-b98f-01b51196320f', 'anonymous'),
  ('019feb75-89e0-73ba-8c7a-8f4d5e9133c2', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', 'administrator'),
  ('019feb75-89e2-7368-a1be-179695439a84', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', 'authenticated'),
  ('019feb75-89e3-7a24-a405-690f2be750dd', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', 'anonymous'),
  ('019feb75-8a0f-7e58-9e4a-206f4dbba51a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a0e-7a45-8898-85dfd6f8e078', 'administrator'),
  ('019feb75-8a11-7968-b7ab-7bb0cb04400f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a0e-7a45-8898-85dfd6f8e078', 'authenticated'),
  ('019feb75-8a13-7036-afc9-316d10b4394f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a0e-7a45-8898-85dfd6f8e078', 'anonymous'),
  ('019feb75-8a1a-77b4-ac95-b0b65f3a7136', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a17-7f4e-89e7-80c6ce5095d1', 'administrator'),
  ('019feb75-8a1b-7fe7-90d8-a1f7a66e77a1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a17-7f4e-89e7-80c6ce5095d1', 'authenticated'),
  ('019feb75-8a1d-76db-bb9f-79f3dc8fce40', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a17-7f4e-89e7-80c6ce5095d1', 'anonymous'),
  ('019feb75-8bea-7b97-bd55-b31774c3ea62', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8be9-73c3-b3e4-bf7ac46b5d76', 'administrator'),
  ('019feb75-8bec-7b20-9757-e8ca137d80e2', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8be9-73c3-b3e4-bf7ac46b5d76', 'authenticated'),
  ('019feb75-8bee-72d0-868b-568b314a55f8', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8be9-73c3-b3e4-bf7ac46b5d76', 'anonymous'),
  ('019feb75-8bf6-77da-8009-6fca270adf63', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bf4-70ee-94b8-840941a142ac', 'administrator'),
  ('019feb75-8bf8-7052-ab24-62f06e2603b3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bf4-70ee-94b8-840941a142ac', 'authenticated'),
  ('019feb75-8bf9-7748-b3b3-f94c692d8cab', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bf4-70ee-94b8-840941a142ac', 'anonymous'),
  ('019feb75-8d98-7762-ac68-9434d6582e1c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8d96-7cbf-ad3f-be66a626a045', 'administrator'),
  ('019feb75-8d9a-757c-8614-e6e2111ddaf0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8d96-7cbf-ad3f-be66a626a045', 'authenticated'),
  ('019feb75-8d9b-7dba-aef7-56a180fc5958', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8d96-7cbf-ad3f-be66a626a045', 'anonymous'),
  ('019feb75-92b7-79ad-a6d8-b2b63d119719', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92b6-7057-b8de-bd46f3aaef00', 'administrator'),
  ('019feb75-92b9-793c-a583-3d256f5f8537', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92b6-7057-b8de-bd46f3aaef00', 'authenticated'),
  ('019feb75-92bb-743b-b498-ac9764e7435a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92b6-7057-b8de-bd46f3aaef00', 'anonymous'),
  ('019feb75-92c2-7b7e-8063-644e5f87eddb', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92c0-733c-80f8-574ce7b97940', 'administrator'),
  ('019feb75-92c4-74a1-9aa5-8bcd6cab6091', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92c0-733c-80f8-574ce7b97940', 'authenticated'),
  ('019feb75-92c5-7cd5-a06d-21e381b1cc71', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92c0-733c-80f8-574ce7b97940', 'anonymous');


SET session_replication_role TO DEFAULT;


