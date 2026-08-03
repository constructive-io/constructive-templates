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
  ('019fc105-1b98-7362-9cc9-f3bdbf24212f', '019fc105-1b97-7f58-bbb7-144d1b28deba', 'Myapp', 'Application powered by Myapp', '{"url":"https://constructive.io/og_image/constructive.jpg","mime":"image/jpeg"}', '019fc104-f28d-7b9c-8d9d-8f338def573c');


SET session_replication_role TO DEFAULT;


