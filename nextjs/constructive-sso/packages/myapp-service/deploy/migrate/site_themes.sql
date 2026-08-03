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
  ('019fc105-1b98-7a6b-85e0-83e9361e5dbc', '019fc105-1b97-7f58-bbb7-144d1b28deba', '{"colors":["#66d9ff","#91d5ee","#ffffff","#33CCFF"],"primary":"#01A1FF","background":"#f2fafd"}', '019fc104-f28d-7b9c-8d9d-8f338def573c');


SET session_replication_role TO DEFAULT;


