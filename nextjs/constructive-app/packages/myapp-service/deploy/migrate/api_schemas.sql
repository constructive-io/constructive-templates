-- Deploy: migrate/api_schemas
-- made with <3 @ constructive.io

-- requires: migrate/memberships_module


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

INSERT INTO routing_public.api_schemas (
  id,
  api_id,
  schema_id,
  database_id
) VALUES
  ('019feb75-78e1-7ba7-a3c4-48a0a917b743', '019feb75-78e1-7197-a9bd-7f9075c774b2', '019feb75-78d6-7cd0-9533-31bd8de066b8', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-797a-749d-9373-d32550cf3674', '019feb75-797a-7084-aa15-4fa0cfa05f39', '019feb75-7969-7069-ae1a-42277e7befea', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-79c5-7e83-9c6a-1317450aca19', '019feb75-79c5-7aca-bac5-7e2c2ebb0400', '019feb75-79b4-722d-bbc4-c5ef8a53db6b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-7b65-749c-a929-b829bbe4503f', '019feb75-797a-7084-aa15-4fa0cfa05f39', '019feb75-7938-77e1-8f66-717a7e6e05de', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-7cb7-7461-807a-7586232f443a', '019feb75-797a-7084-aa15-4fa0cfa05f39', '019feb75-7ca3-764e-895e-58b77d9a5f1d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-8966-7538-ad1c-e85339caee03', '019feb75-8966-7142-a594-0faf10ac7cd3', '019feb75-895b-7b97-b98f-01b51196320f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-89e8-7ff3-882d-ea6560ce443f', '019feb75-78e1-7197-a9bd-7f9075c774b2', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-8a22-7b43-8fe1-ce188b4a9a05', '019feb75-78e1-7197-a9bd-7f9075c774b2', '019feb75-8a0e-7a45-8898-85dfd6f8e078', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-8bf3-7e8a-96c1-ce6cd54a0387', '019feb75-797a-7084-aa15-4fa0cfa05f39', '019feb75-8be9-73c3-b3e4-bf7ac46b5d76', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-8da1-77ec-b96a-a99254760008', '019feb75-78e1-7197-a9bd-7f9075c774b2', '019feb75-8d96-7cbf-ad3f-be66a626a045', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-9403-729a-87a6-08d11cb0d97c', '019feb75-9402-7b4f-b836-399f826c4fb0', '019feb75-784c-7932-a3b6-33342f1bff0c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b97f-77ef-8ce9-b29f01156ec4', '019feb75-9402-7b4f-b836-399f826c4fb0', '019feb75-78d6-7cd0-9533-31bd8de066b8', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b982-749d-9bf3-095d1eb57320', '019feb75-9402-7b4f-b836-399f826c4fb0', '019feb75-7938-77e1-8f66-717a7e6e05de', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b982-7e58-84b0-3910dcebedd6', '019feb75-9402-7b4f-b836-399f826c4fb0', '019feb75-7969-7069-ae1a-42277e7befea', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b983-76d2-a6cf-9a7ac075e1d9', '019feb75-9402-7b4f-b836-399f826c4fb0', '019feb75-79b4-722d-bbc4-c5ef8a53db6b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b983-7f06-a46a-2daa61e44d03', '019feb75-9402-7b4f-b836-399f826c4fb0', '019feb75-7ca3-764e-895e-58b77d9a5f1d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b984-76c2-bc11-c2bd61427ab3', '019feb75-9402-7b4f-b836-399f826c4fb0', '019feb75-895b-7b97-b98f-01b51196320f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b984-7de6-baed-79a095fdb0e2', '019feb75-9402-7b4f-b836-399f826c4fb0', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b985-74b6-9bff-74af8b40bfc2', '019feb75-9402-7b4f-b836-399f826c4fb0', '019feb75-8a0e-7a45-8898-85dfd6f8e078', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b985-7bcc-8924-0085d5d82fe4', '019feb75-9402-7b4f-b836-399f826c4fb0', '019feb75-8be9-73c3-b3e4-bf7ac46b5d76', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b986-7217-8f51-1e9e29c53fa8', '019feb75-9402-7b4f-b836-399f826c4fb0', '019feb75-8d96-7cbf-ad3f-be66a626a045', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b986-790b-9ae4-829f06e16dc5', '019feb75-9402-7b4f-b836-399f826c4fb0', '019feb75-92b6-7057-b8de-bd46f3aaef00', '019feb75-7843-7bd5-a19f-88c4cbec0ee6'),
  ('019feb75-b9b1-7e2c-8c08-49d47f861bc5', '019feb75-b40f-7c2a-b4b0-fe1bf220facd', 'fc04bdf6-abfa-55c6-74eb-4f765f024f7a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6');


SET session_replication_role TO DEFAULT;


