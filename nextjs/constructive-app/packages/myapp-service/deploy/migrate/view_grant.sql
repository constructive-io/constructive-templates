-- Deploy: migrate/view_grant
-- made with <3 @ constructive.io

-- requires: migrate/view_behavior


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

INSERT INTO metaschema_public.view_grant (
  id,
  database_id,
  view_id,
  grantee_name,
  privilege,
  with_grant_option,
  is_grant
) VALUES
  ('019feb75-87cb-7229-a426-c6f4e6138a73', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87c0-719e-8ed0-edba70fd3ce1', 'authenticated', 'SELECT', false, true),
  ('019feb75-87d5-72e2-a8d5-945c2ed03763', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87cc-7dcd-9a63-a483ec264440', 'authenticated', 'SELECT', false, true),
  ('019feb75-89b5-7aa3-8276-2f7d1950576d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89ae-72d5-b03b-8773c41c571f', 'authenticated', 'SELECT', false, true),
  ('019feb75-8b7c-7528-aebf-fbed82fedee4', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b74-7390-b746-225bdae365ce', 'authenticated', 'SELECT', false, true),
  ('019feb75-8be0-7407-985d-a833ee0360fb', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bda-7193-ad61-35648599d0e3', 'authenticated', 'SELECT', false, true),
  ('019feb75-9236-747b-b797-a216c7de5720', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-922c-73db-91d7-934470e13412', 'authenticated', 'SELECT', false, true);


SET session_replication_role TO DEFAULT;


