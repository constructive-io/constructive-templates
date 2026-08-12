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
  ('019feb75-7877-729b-92e8-013b58e5210c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784c-7932-a3b6-33342f1bff0c', 'tables', 'ALL', 'administrator', true),
  ('019feb75-787e-7ee6-a008-f34487ecf5bf', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784c-7932-a3b6-33342f1bff0c', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-7884-7be8-856e-93e508a2d6ef', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784c-7932-a3b6-33342f1bff0c', 'functions', 'ALL', 'administrator', true),
  ('019feb75-788a-7739-8161-0198057a1c5c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784c-7932-a3b6-33342f1bff0c', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-7891-7677-94e1-17e4e12b3a97', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784c-7932-a3b6-33342f1bff0c', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-78b6-7119-a270-daaec1346de7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784d-7576-93a4-c922966ef5da', 'tables', 'ALL', 'administrator', true),
  ('019feb75-78bc-7998-b8aa-c069db1ca759', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784d-7576-93a4-c922966ef5da', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-78c2-7481-9126-19f1571450e3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784d-7576-93a4-c922966ef5da', 'functions', 'ALL', 'administrator', true),
  ('019feb75-78c7-7eee-991f-8d057e0f0736', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784d-7576-93a4-c922966ef5da', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-78cd-759f-bbdb-3c06a2eceda7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-784d-7576-93a4-c922966ef5da', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-78dc-7af9-891f-7566818ef561', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78d6-7cd0-9533-31bd8de066b8', 'tables', 'ALL', 'administrator', true),
  ('019feb75-78dd-7d89-af51-241f30fa5243', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78d6-7cd0-9533-31bd8de066b8', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-78de-73ae-91eb-5c57961a1f55', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78d6-7cd0-9533-31bd8de066b8', 'functions', 'ALL', 'administrator', true),
  ('019feb75-78de-7a38-a5f3-5b097049de07', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78d6-7cd0-9533-31bd8de066b8', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-78de-7e4a-b4d3-23962da2b7ca', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78d6-7cd0-9533-31bd8de066b8', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-793d-7979-81c8-ee87f2cd21e1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7938-77e1-8f66-717a7e6e05de', 'tables', 'ALL', 'administrator', true),
  ('019feb75-793e-7d3d-9676-ee880793344d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7938-77e1-8f66-717a7e6e05de', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-793f-741b-ac60-715e145f47ec', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7938-77e1-8f66-717a7e6e05de', 'functions', 'ALL', 'administrator', true),
  ('019feb75-793f-7a8d-94d7-ab625433a902', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7938-77e1-8f66-717a7e6e05de', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-793f-7eff-b62a-65e8f5aa54de', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7938-77e1-8f66-717a7e6e05de', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-796d-7eef-9438-e0616695a043', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7969-7069-ae1a-42277e7befea', 'tables', 'ALL', 'administrator', true),
  ('019feb75-796f-725a-83d6-38be69070640', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7969-7069-ae1a-42277e7befea', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-796f-786c-be7e-3b32ddd74f5f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7969-7069-ae1a-42277e7befea', 'functions', 'ALL', 'administrator', true),
  ('019feb75-796f-7e78-888a-21ada2f3b3a7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7969-7069-ae1a-42277e7befea', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-7970-7212-904a-ee45e06f91c3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7969-7069-ae1a-42277e7befea', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-7976-78a0-b6ba-423c454785ba', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7970-7957-8ea7-b79d4615b62c', 'tables', 'ALL', 'administrator', true),
  ('019feb75-7977-7f1d-b54f-35962b88f1df', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7970-7957-8ea7-b79d4615b62c', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-7978-7586-a636-8fd5c61e3876', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7970-7957-8ea7-b79d4615b62c', 'functions', 'ALL', 'administrator', true),
  ('019feb75-7978-7bb2-93ec-374ce68a0ff3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7970-7957-8ea7-b79d4615b62c', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-7978-7f9c-a570-c5e13225baea', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7970-7957-8ea7-b79d4615b62c', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-79b9-73ed-92d3-976eb855a004', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79b4-722d-bbc4-c5ef8a53db6b', 'tables', 'ALL', 'administrator', true),
  ('019feb75-79ba-7782-b622-8b0a8d830585', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79b4-722d-bbc4-c5ef8a53db6b', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-79ba-7f52-9cf8-75fccb0bc9b2', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79b4-722d-bbc4-c5ef8a53db6b', 'functions', 'ALL', 'administrator', true),
  ('019feb75-79bb-76b1-a5a5-f9faaa1ef286', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79b4-722d-bbc4-c5ef8a53db6b', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-79bb-7b8b-bb23-e0b06da7dff6', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79b4-722d-bbc4-c5ef8a53db6b', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-79c2-7289-9abc-9f908a24f3a9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79bc-73be-9da4-a0da9c33a7fc', 'tables', 'ALL', 'administrator', true),
  ('019feb75-79c3-773b-883f-ee6a2263bf3b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79bc-73be-9da4-a0da9c33a7fc', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-79c3-7ec0-a388-25636ee2d26d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79bc-73be-9da4-a0da9c33a7fc', 'functions', 'ALL', 'administrator', true),
  ('019feb75-79c4-7519-aa15-a5faa041a4ad', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79bc-73be-9da4-a0da9c33a7fc', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-79c4-7a0b-b748-503f810baca3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-79bc-73be-9da4-a0da9c33a7fc', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-7b61-7a10-b0a4-a21baeb12bff', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b5c-710b-a201-95a6bb0962be', 'tables', 'ALL', 'administrator', true),
  ('019feb75-7b62-7e95-bed3-be8e22387a6e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b5c-710b-a201-95a6bb0962be', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-7b63-75b8-ba9b-f2d9574e2296', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b5c-710b-a201-95a6bb0962be', 'functions', 'ALL', 'administrator', true),
  ('019feb75-7b63-7d24-8730-8c2a29cc896d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b5c-710b-a201-95a6bb0962be', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-7b64-71d2-afed-87f723a628f7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7b5c-710b-a201-95a6bb0962be', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-7ca9-78c0-8712-ad6b68bad794', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ca3-764e-895e-58b77d9a5f1d', 'tables', 'ALL', 'administrator', true),
  ('019feb75-7caa-7f47-858b-a629624cd226', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ca3-764e-895e-58b77d9a5f1d', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-7cab-76ef-b2e2-6d28881f729d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ca3-764e-895e-58b77d9a5f1d', 'functions', 'ALL', 'administrator', true),
  ('019feb75-7cab-7e49-b53f-560a0bbc3d19', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ca3-764e-895e-58b77d9a5f1d', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-7cac-732a-ac4a-e21840de9a68', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7ca3-764e-895e-58b77d9a5f1d', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-7cb3-7a7f-b4bb-40d375db3fa6', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cac-7b80-82dd-d18a956a7fdc', 'tables', 'ALL', 'administrator', true),
  ('019feb75-7cb4-7e2e-9e70-5433208b8a1c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cac-7b80-82dd-d18a956a7fdc', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-7cb5-74f0-b131-b324a3e4a25b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cac-7b80-82dd-d18a956a7fdc', 'functions', 'ALL', 'administrator', true),
  ('019feb75-7cb5-7be7-9545-76efdc764e03', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cac-7b80-82dd-d18a956a7fdc', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-7cb6-70cd-9e00-9bb0f2b8f5f6', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7cac-7b80-82dd-d18a956a7fdc', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-865e-783e-ad7b-cb50b36f654d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8658-74d1-9931-76da2692e55d', 'tables', 'ALL', 'administrator', true),
  ('019feb75-8660-74a2-80a2-fbca93ea204f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8658-74d1-9931-76da2692e55d', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-8660-7d5b-92fc-ac458513cffd', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8658-74d1-9931-76da2692e55d', 'functions', 'ALL', 'administrator', true),
  ('019feb75-8661-74ea-a4bf-1dac1436f545', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8658-74d1-9931-76da2692e55d', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-8661-79eb-b72a-49500dbdd224', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8658-74d1-9931-76da2692e55d', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-869b-7e4c-9204-d7ca0c9d754c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', 'tables', 'ALL', 'administrator', true),
  ('019feb75-869d-721e-959f-035881926273', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-869d-7962-aef8-aefcc6b31a1f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', 'functions', 'ALL', 'administrator', true),
  ('019feb75-869e-705a-b917-cc106ccc0e14', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-869e-754f-9292-f3b9213e30af', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-8962-73cf-98a1-5b341cc999a4', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-895b-7b97-b98f-01b51196320f', 'tables', 'ALL', 'administrator', true),
  ('019feb75-8963-79a3-b707-a3d812f9f4f4', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-895b-7b97-b98f-01b51196320f', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-8964-717c-8afa-e27906d80dca', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-895b-7b97-b98f-01b51196320f', 'functions', 'ALL', 'administrator', true),
  ('019feb75-8964-7961-a553-153d2c2037d8', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-895b-7b97-b98f-01b51196320f', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-8964-7eaf-9c12-5342f7be5cf9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-895b-7b97-b98f-01b51196320f', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-89e5-72a3-97f9-6295ec27d1c8', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', 'tables', 'ALL', 'administrator', true),
  ('019feb75-89e6-779d-91df-748a37d1b7c6', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-89e6-7fcf-9c3b-f40f06cf8337', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', 'functions', 'ALL', 'administrator', true),
  ('019feb75-89e7-76fe-b6aa-4b9c188161c4', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-89e7-7c46-820f-64ebc8b46e51', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-8a14-791c-8815-5c6211b4ac85', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a0e-7a45-8898-85dfd6f8e078', 'tables', 'ALL', 'administrator', true),
  ('019feb75-8a15-7f14-8a1c-eeb8e01f3e47', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a0e-7a45-8898-85dfd6f8e078', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-8a16-76ba-96ac-c7aa81fb8747', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a0e-7a45-8898-85dfd6f8e078', 'functions', 'ALL', 'administrator', true),
  ('019feb75-8a17-70da-9af7-b189bbd28a01', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a0e-7a45-8898-85dfd6f8e078', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-8a17-7604-a56a-3e715e80fb94', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a0e-7a45-8898-85dfd6f8e078', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-8a1e-7e92-8f2a-a334d99b2dac', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a17-7f4e-89e7-80c6ce5095d1', 'tables', 'ALL', 'administrator', true),
  ('019feb75-8a20-730a-8d1b-128733a772b1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a17-7f4e-89e7-80c6ce5095d1', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-8a20-7b4d-b2cb-feec9d0e5b0c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a17-7f4e-89e7-80c6ce5095d1', 'functions', 'ALL', 'administrator', true),
  ('019feb75-8a21-7298-93db-9cc8500919bf', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a17-7f4e-89e7-80c6ce5095d1', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-8a21-7819-8056-8621eac7902b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8a17-7f4e-89e7-80c6ce5095d1', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-8bf0-7061-880d-af0963e59e35', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8be9-73c3-b3e4-bf7ac46b5d76', 'tables', 'ALL', 'administrator', true),
  ('019feb75-8bf1-752f-9ec0-e83789122b46', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8be9-73c3-b3e4-bf7ac46b5d76', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-8bf1-7db8-a6d2-de0260f32030', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8be9-73c3-b3e4-bf7ac46b5d76', 'functions', 'ALL', 'administrator', true),
  ('019feb75-8bf2-74f2-aa27-8ca8d0a412cd', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8be9-73c3-b3e4-bf7ac46b5d76', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-8bf2-7a51-a324-1eea479a79b2', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8be9-73c3-b3e4-bf7ac46b5d76', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-8bfa-7ffc-9eb1-0e0c7e415b0a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bf4-70ee-94b8-840941a142ac', 'tables', 'ALL', 'administrator', true),
  ('019feb75-8bfc-72d3-a857-e72379ff55a0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bf4-70ee-94b8-840941a142ac', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-8bfc-7a20-ae28-f49d6a8b88e0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bf4-70ee-94b8-840941a142ac', 'functions', 'ALL', 'administrator', true),
  ('019feb75-8bfd-7152-88aa-843cdeb05f4f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bf4-70ee-94b8-840941a142ac', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-8bfd-76c6-9b51-71d391cb2399', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bf4-70ee-94b8-840941a142ac', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-8d9d-7839-ac9a-a96efc777437', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8d96-7cbf-ad3f-be66a626a045', 'tables', 'ALL', 'administrator', true),
  ('019feb75-8d9e-7eab-8f39-8e3d71b592e7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8d96-7cbf-ad3f-be66a626a045', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-8d9f-7666-ab2b-9d013b7a0ec1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8d96-7cbf-ad3f-be66a626a045', 'functions', 'ALL', 'administrator', true),
  ('019feb75-8d9f-7de9-a1bc-19ce34a62031', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8d96-7cbf-ad3f-be66a626a045', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-8da0-735c-9511-3f76a355eb7b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8d96-7cbf-ad3f-be66a626a045', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-92bc-7ece-83ea-65d22e911ada', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92b6-7057-b8de-bd46f3aaef00', 'tables', 'ALL', 'administrator', true),
  ('019feb75-92be-74ae-9781-05c0e1ce3df1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92b6-7057-b8de-bd46f3aaef00', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-92be-7d7e-a91a-a9d194780027', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92b6-7057-b8de-bd46f3aaef00', 'functions', 'ALL', 'administrator', true),
  ('019feb75-92bf-74ed-97f8-001a785003f3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92b6-7057-b8de-bd46f3aaef00', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-92bf-7a5c-85d8-668f67ee7404', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92b6-7057-b8de-bd46f3aaef00', 'sequences', 'ALL', 'authenticated', true),
  ('019feb75-92c7-797e-8a16-4b4f7140913a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92c0-733c-80f8-574ce7b97940', 'tables', 'ALL', 'administrator', true),
  ('019feb75-92c8-7e00-b38f-7a472d87c34d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92c0-733c-80f8-574ce7b97940', 'sequences', 'ALL', 'administrator', true),
  ('019feb75-92c9-756b-a219-cf00ad7c0b24', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92c0-733c-80f8-574ce7b97940', 'functions', 'ALL', 'administrator', true),
  ('019feb75-92c9-7cdd-8fde-1496145ec46a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92c0-733c-80f8-574ce7b97940', 'functions', 'ALL', 'authenticated', true),
  ('019feb75-92ca-720b-a093-20167f60906f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92c0-733c-80f8-574ce7b97940', 'sequences', 'ALL', 'authenticated', true);


SET session_replication_role TO DEFAULT;


