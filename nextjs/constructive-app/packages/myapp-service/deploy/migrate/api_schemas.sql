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
  ('019fbc96-8532-7d33-9953-b60a4039f38c', '019fbc96-8532-70ad-82b8-cba1946925a2', '019fbc96-8518-71f6-b5dd-e68f7390e1e2', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-8659-7e29-9383-600475528546', '019fbc96-8659-7990-b05a-e190bd1190af', '019fbc96-862f-76db-9baa-23b094401fe1', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-86ff-7bc9-b800-0bddc97f19c7', '019fbc96-86ff-77df-af4f-455a6af96d90', '019fbc96-86cf-7ef2-a529-3dd72c52bfad', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-8a9f-7837-a749-06c378bc3de3', '019fbc96-8659-7990-b05a-e190bd1190af', '019fbc96-85d4-7f68-b449-545fb41b37d8', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-8e78-75fa-92e1-9f935f105035', '019fbc96-8659-7990-b05a-e190bd1190af', '019fbc96-8e34-7092-8399-48a2a3e2d57a', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-bf35-7abc-b3f7-609a4952628d', '019fbc96-bf35-76f8-a63b-93787a2ed1eb', '019fbc96-beef-7f41-8222-679237757808', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-c176-773c-8d18-2a4d22643dd0', '019fbc96-8532-70ad-82b8-cba1946925a2', '019fbc96-c130-7558-9bec-78482a963cfe', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-c250-765f-b10c-80ce16583968', '019fbc96-8532-70ad-82b8-cba1946925a2', '019fbc96-c1c4-7d76-8017-c296fd0375c5', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-cbab-7386-b803-7c432b551f40', '019fbc96-8659-7990-b05a-e190bd1190af', '019fbc96-cb64-72af-8517-bb56ec9a9e4a', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-d42e-76b1-a4b0-8e76929021b6', '019fbc96-8532-70ad-82b8-cba1946925a2', '019fbc96-d3d8-7d28-be68-51cccf808408', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-e51e-7bab-aa32-47a46df83a30', '019fbc96-e51c-7f70-8057-8db4e69e84dd', '019fbc96-84dd-714a-9115-59c358d447fd', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-f776-78b5-a609-d8b457c3a71a', '019fbc96-e51c-7f70-8057-8db4e69e84dd', '019fbc96-8518-71f6-b5dd-e68f7390e1e2', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-f77b-70ff-9b73-cd3f83e72bb1', '019fbc96-e51c-7f70-8057-8db4e69e84dd', '019fbc96-85d4-7f68-b449-545fb41b37d8', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-f77b-79f7-9862-0c4deea55ed5', '019fbc96-e51c-7f70-8057-8db4e69e84dd', '019fbc96-862f-76db-9baa-23b094401fe1', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-f77c-71d1-877a-45dd141f4496', '019fbc96-e51c-7f70-8057-8db4e69e84dd', '019fbc96-86cf-7ef2-a529-3dd72c52bfad', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-f77c-79cd-ae48-d01bd99da9f0', '019fbc96-e51c-7f70-8057-8db4e69e84dd', '019fbc96-8e34-7092-8399-48a2a3e2d57a', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-f77d-71b6-936e-c083d22138e6', '019fbc96-e51c-7f70-8057-8db4e69e84dd', '019fbc96-beef-7f41-8222-679237757808', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-f77d-786f-876c-2cad488fe914', '019fbc96-e51c-7f70-8057-8db4e69e84dd', '019fbc96-c130-7558-9bec-78482a963cfe', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-f77d-7eb5-896e-64f474b9a63f', '019fbc96-e51c-7f70-8057-8db4e69e84dd', '019fbc96-c1c4-7d76-8017-c296fd0375c5', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-f77e-7431-8086-018196713ed2', '019fbc96-e51c-7f70-8057-8db4e69e84dd', '019fbc96-cb64-72af-8517-bb56ec9a9e4a', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-f77e-7994-862a-33160b551a9b', '019fbc96-e51c-7f70-8057-8db4e69e84dd', '019fbc96-d3d8-7d28-be68-51cccf808408', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-f77e-7e9e-9629-854528e5746a', '019fbc96-e51c-7f70-8057-8db4e69e84dd', '019fbc96-ded7-7d8d-9998-193c21acc329', '019fbc96-84d8-7d13-8acc-4c55ad35634c'),
  ('019fbc96-f7a8-71ed-b7cd-48e69f3f9364', '019fbc96-e54f-71c3-b80e-b3c6c6ed8d82', 'fc04bdf6-abfa-55c6-74eb-4f765f024f7a', '019fbc96-84d8-7d13-8acc-4c55ad35634c');


SET session_replication_role TO DEFAULT;


