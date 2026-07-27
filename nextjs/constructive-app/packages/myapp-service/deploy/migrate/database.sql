-- Deploy: migrate/database
-- made with <3 @ constructive.io




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

INSERT INTO metaschema_public.database (
  id,
  owner_id,
  schema_hash,
  name,
  label,
  hash,
  platform
) VALUES
  ('019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-417e-7ea3-88e6-5b2117282f5f', 'myapp', 'myapp', 'myapp', 'd97c3a06-97b5-56c3-9f3d-72aefb17a842', false);


SET session_replication_role TO DEFAULT;


