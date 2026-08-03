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
  ('019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-7600-7b6d-a15d-f6cf135d81d3', 'myapp', 'myapp', 'myapp', '719858a1-bac6-5dab-b000-203aad4d560d', false);


SET session_replication_role TO DEFAULT;


