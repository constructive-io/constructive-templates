-- Deploy: migrate/site_themes
-- made with <3 @ constructive.io

-- requires: migrate/site_modules


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

INSERT INTO routing_public.site_themes (
  id,
  site_id,
  theme,
  database_id
) VALUES
  ('019fbc96-e52c-7470-9b9e-0d2caeaa6390', '019fbc96-e52b-7808-9807-fbed9c4b97f0', '{"colors":["#66d9ff","#91d5ee","#ffffff","#33CCFF"],"primary":"#01A1FF","background":"#f2fafd"}', '019fbc96-84d8-7d13-8acc-4c55ad35634c');


SET session_replication_role TO DEFAULT;


