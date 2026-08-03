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
  ('019fbc96-84e7-71b1-a850-de3782c4434c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-84dd-714a-9115-59c358d447fd', 'administrator'),
  ('019fbc96-84eb-74d4-8d0a-e0f4f57bf24c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-84dd-714a-9115-59c358d447fd', 'authenticated'),
  ('019fbc96-84ee-7501-91cd-a1301861d0bb', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-84dd-714a-9115-59c358d447fd', 'anonymous'),
  ('019fbc96-8500-79a0-b1ca-5a8b70a4674d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-84dd-7a35-9480-d77f89efe0ee', 'administrator'),
  ('019fbc96-8503-7c9b-b993-828311a87fa2', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-84dd-7a35-9480-d77f89efe0ee', 'authenticated'),
  ('019fbc96-8506-7cad-865c-22bacfd14aa2', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-84dd-7a35-9480-d77f89efe0ee', 'anonymous'),
  ('019fbc96-851b-7894-85df-dc97f2efe8d9', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8518-71f6-b5dd-e68f7390e1e2', 'administrator'),
  ('019fbc96-851e-779a-9231-4c7707336944', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8518-71f6-b5dd-e68f7390e1e2', 'authenticated'),
  ('019fbc96-8521-76fe-81ec-dce4f293472f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8518-71f6-b5dd-e68f7390e1e2', 'anonymous'),
  ('019fbc96-85d7-7483-8d26-39efdcefbb68', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-85d4-7f68-b449-545fb41b37d8', 'administrator'),
  ('019fbc96-85da-72e4-b93e-93bc1671d6fe', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-85d4-7f68-b449-545fb41b37d8', 'authenticated'),
  ('019fbc96-85dd-732b-94c6-54c049bfd624', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-85d4-7f68-b449-545fb41b37d8', 'anonymous'),
  ('019fbc96-8631-76cc-9fea-8e4cb05eb6ee', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-862f-76db-9baa-23b094401fe1', 'administrator'),
  ('019fbc96-8634-73be-86f7-efdf66830043', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-862f-76db-9baa-23b094401fe1', 'authenticated'),
  ('019fbc96-8636-7f26-b312-c11d11cff329', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-862f-76db-9baa-23b094401fe1', 'anonymous'),
  ('019fbc96-8646-79f3-8a1f-0fd15223d4a3', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8643-7a6d-8e04-033c76db6ad6', 'administrator'),
  ('019fbc96-8649-74b3-9f92-c7588daf6100', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8643-7a6d-8e04-033c76db6ad6', 'authenticated'),
  ('019fbc96-864b-7fb8-b899-1d9e88595352', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8643-7a6d-8e04-033c76db6ad6', 'anonymous'),
  ('019fbc96-86d2-7390-8a54-bebb23017474', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-86cf-7ef2-a529-3dd72c52bfad', 'administrator'),
  ('019fbc96-86d5-73fe-9733-e3f6b1511aae', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-86cf-7ef2-a529-3dd72c52bfad', 'authenticated'),
  ('019fbc96-86d8-792e-89ac-d2351494bdb1', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-86cf-7ef2-a529-3dd72c52bfad', 'anonymous'),
  ('019fbc96-86ea-7f75-b075-ac28b40013d0', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-86e7-79b0-a4ec-3be5025c1b2e', 'administrator'),
  ('019fbc96-86ed-7b4a-a5d6-242ba9db905b', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-86e7-79b0-a4ec-3be5025c1b2e', 'authenticated'),
  ('019fbc96-86f0-78e5-9123-d217e72a4a74', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-86e7-79b0-a4ec-3be5025c1b2e', 'anonymous'),
  ('019fbc96-8a84-7f1a-b2cd-56da4aa876d8', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8a81-7f7c-a48a-5a22ff96b8b1', 'administrator'),
  ('019fbc96-8a88-7e82-9a82-7895e6274241', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8a81-7f7c-a48a-5a22ff96b8b1', 'authenticated'),
  ('019fbc96-8a8c-77eb-bbdd-9f61a60de467', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8a81-7f7c-a48a-5a22ff96b8b1', 'anonymous'),
  ('019fbc96-8e37-75cb-95f8-49a3b83d5324', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8e34-7092-8399-48a2a3e2d57a', 'administrator'),
  ('019fbc96-8e3b-723c-bea6-ab9e6a01dcc3', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8e34-7092-8399-48a2a3e2d57a', 'authenticated'),
  ('019fbc96-8e3f-7296-85fb-8d62e8a54f23', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8e34-7092-8399-48a2a3e2d57a', 'anonymous'),
  ('019fbc96-8e59-7d27-8512-b6ff894d5f58', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8e55-7985-8a70-cd6ede5e4c5c', 'administrator'),
  ('019fbc96-8e5d-7a4f-949f-f48720513d44', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8e55-7985-8a70-cd6ede5e4c5c', 'authenticated'),
  ('019fbc96-8e61-714a-88bf-95a2d745898d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8e55-7985-8a70-cd6ede5e4c5c', 'anonymous'),
  ('019fbc96-ad28-7470-9f70-6bb21ec368c4', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ad22-7c7e-a51b-2988c7c7d29f', 'administrator'),
  ('019fbc96-ad2e-71c0-8eec-53851554073d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ad22-7c7e-a51b-2988c7c7d29f', 'authenticated'),
  ('019fbc96-ad33-71d0-afe4-f5de34e265f2', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ad22-7c7e-a51b-2988c7c7d29f', 'anonymous'),
  ('019fbc96-ae0c-708f-bfd5-b9e908b57f4f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ae06-75fc-96c3-df2484d13ce6', 'administrator'),
  ('019fbc96-ae11-7ccf-a248-a504aea2d71d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ae06-75fc-96c3-df2484d13ce6', 'authenticated'),
  ('019fbc96-ae18-7bc4-9b46-7164d0a236de', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ae06-75fc-96c3-df2484d13ce6', 'anonymous'),
  ('019fbc96-bef6-75e8-b0d4-14035f1327fb', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-beef-7f41-8222-679237757808', 'administrator'),
  ('019fbc96-befc-7814-89d6-eb1463dacab4', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-beef-7f41-8222-679237757808', 'authenticated'),
  ('019fbc96-bf03-7c47-893c-d0c682ebebd9', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-beef-7f41-8222-679237757808', 'anonymous'),
  ('019fbc96-c137-7ba0-8550-9b1f6c97372f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c130-7558-9bec-78482a963cfe', 'administrator'),
  ('019fbc96-c13d-7fb0-8964-d8998b4edb88', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c130-7558-9bec-78482a963cfe', 'authenticated'),
  ('019fbc96-c144-7cf4-af54-aabc2c29b858', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c130-7558-9bec-78482a963cfe', 'anonymous'),
  ('019fbc96-c1cc-732f-bb18-35e3d4441a70', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c1c4-7d76-8017-c296fd0375c5', 'administrator'),
  ('019fbc96-c1d3-75f1-9515-8fcdf7cffaf8', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c1c4-7d76-8017-c296fd0375c5', 'authenticated'),
  ('019fbc96-c1da-7319-a325-eae4f2792cb5', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c1c4-7d76-8017-c296fd0375c5', 'anonymous'),
  ('019fbc96-c211-7d96-8389-2e666fa7ccbc', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c208-7fd4-a19a-6650fdd93969', 'administrator'),
  ('019fbc96-c218-7520-8cf1-8986ef269a17', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c208-7fd4-a19a-6650fdd93969', 'authenticated'),
  ('019fbc96-c21e-7cc2-9c61-520fa070e299', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c208-7fd4-a19a-6650fdd93969', 'anonymous'),
  ('019fbc96-cb6b-7531-aabe-1cbed45a0eec', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cb64-72af-8517-bb56ec9a9e4a', 'administrator'),
  ('019fbc96-cb72-7f3a-a097-71292ae26bc2', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cb64-72af-8517-bb56ec9a9e4a', 'authenticated'),
  ('019fbc96-cb79-7c2b-9823-808d19cca6b5', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cb64-72af-8517-bb56ec9a9e4a', 'anonymous'),
  ('019fbc96-cbb3-7939-a7da-a2e08ed7d856', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cbab-7606-911c-c330b58955f9', 'administrator'),
  ('019fbc96-cbbb-7547-bd1e-6dd73a8c0239', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cbab-7606-911c-c330b58955f9', 'authenticated'),
  ('019fbc96-cbc2-714a-9ee3-3aefb43354bd', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cbab-7606-911c-c330b58955f9', 'anonymous'),
  ('019fbc96-d3e1-7020-9f08-711ea7d2dc53', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-d3d8-7d28-be68-51cccf808408', 'administrator'),
  ('019fbc96-d3e9-7e67-af2a-09c102dd14b1', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-d3d8-7d28-be68-51cccf808408', 'authenticated'),
  ('019fbc96-d3f3-7958-8723-7fbfba6183ea', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-d3d8-7d28-be68-51cccf808408', 'anonymous'),
  ('019fbc96-dee1-7252-9b74-b337efc88889', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ded7-7d8d-9998-193c21acc329', 'administrator'),
  ('019fbc96-deeb-7283-81d6-ff04e1c35729', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ded7-7d8d-9998-193c21acc329', 'authenticated'),
  ('019fbc96-def3-7959-89f7-90c7811f96d5', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ded7-7d8d-9998-193c21acc329', 'anonymous'),
  ('019fbc96-df38-7f9d-8ea1-3e51f2870711', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-df2f-79b3-963a-81da5c02e36c', 'administrator'),
  ('019fbc96-df41-7af6-ad54-0f5fa27faea8', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-df2f-79b3-963a-81da5c02e36c', 'authenticated'),
  ('019fbc96-df49-7b5d-84ab-8edc1aabf94f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-df2f-79b3-963a-81da5c02e36c', 'anonymous');


SET session_replication_role TO DEFAULT;


