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
  ('019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-eb0a-76c4-adee-4a97ad29b108', 'myapp', 'myapp', 'myapp', '431370d9-2e01-5544-b1b8-6ebf00376be0', false);


SET session_replication_role TO DEFAULT;


