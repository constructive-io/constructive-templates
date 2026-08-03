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
  ('019fc105-1b97-7f58-bbb7-144d1b28deba', 'site-019fc105-1b97-7f58-bbb7-144d1b28deba', 'Myapp', 'Application powered by Myapp', false, '{"logo":{"url":"https://constructive.io/brand/constructive.png","mime":"image/png"},"favicon":"https://constructive.io/favicon.ico","ogImage":{"url":"https://constructive.io/og_image/constructive.jpg","mime":"image/jpeg"},"appleTouchIcon":{"url":"https://constructive.io/brand/constructive.svg","mime":"image/svg+xml"}}', '019fc104-f28d-7b9c-8d9d-8f338def573c');


SET session_replication_role TO DEFAULT;


