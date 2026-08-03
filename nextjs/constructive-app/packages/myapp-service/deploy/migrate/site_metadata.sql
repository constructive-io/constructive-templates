-- Deploy: migrate/site_metadata
-- made with <3 @ constructive.io

-- requires: migrate/routes


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

INSERT INTO routing_public.site_metadata (
  id,
  site_id,
  title,
  description,
  og_image,
  database_id
) VALUES
  ('019fbc96-e52b-7c8b-b8ef-fc9777616981', '019fbc96-e52b-7808-9807-fbed9c4b97f0', 'Myapp', 'Application powered by Myapp', '{"url":"https://constructive.io/og_image/constructive.jpg","mime":"image/jpeg"}', '019fbc96-84d8-7d13-8acc-4c55ad35634c');


SET session_replication_role TO DEFAULT;


