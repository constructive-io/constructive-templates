-- Deploy: migrate/sites
-- made with <3 @ constructive.io

-- requires: migrate/site_themes


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

INSERT INTO routing_public.sites (
  id,
  name,
  title,
  description,
  is_published,
  config,
  database_id
) VALUES
  ('019fbc96-e52b-7808-9807-fbed9c4b97f0', 'site-019fbc96-e52b-7808-9807-fbed9c4b97f0', 'Myapp', 'Application powered by Myapp', false, '{"logo":{"url":"https://constructive.io/brand/constructive.png","mime":"image/png"},"favicon":"https://constructive.io/favicon.ico","ogImage":{"url":"https://constructive.io/og_image/constructive.jpg","mime":"image/jpeg"},"appleTouchIcon":{"url":"https://constructive.io/brand/constructive.svg","mime":"image/svg+xml"}}', '019fbc96-84d8-7d13-8acc-4c55ad35634c');


SET session_replication_role TO DEFAULT;


