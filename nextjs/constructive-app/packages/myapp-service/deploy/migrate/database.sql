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
  name,
  label,
  hash,
  platform
) VALUES
  ('019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-4c49-7780-8a77-dcb8a722405b', 'myapp', 'myapp', '99a1b692-76ee-51a2-9152-ab6aa712f9a4', false);


SET session_replication_role TO DEFAULT;


