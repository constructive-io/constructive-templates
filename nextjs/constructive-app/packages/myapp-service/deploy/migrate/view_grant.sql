-- Deploy: migrate/view_grant
-- made with <3 @ constructive.io

-- requires: migrate/webauthn_credentials_module


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
  ('019fa2a1-611e-7bcf-9d3e-d46c02de77d9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6109-767a-8bfc-f1bb29779a76', 'authenticated', 'SELECT', false, true),
  ('019fa2a1-6137-7de5-a781-fca7217b1ad1', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6123-71cd-865e-c366636985f4', 'authenticated', 'SELECT', false, true),
  ('019fa2a1-6891-7bda-8fb4-80d4e6c61cc8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-687b-7da2-9fdd-9d73f5d2db1e', 'authenticated', 'SELECT', false, true),
  ('019fa2a1-6dfb-73f7-bd90-482827e572a6', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6de2-79f4-af72-b983ba08bf0f', 'authenticated', 'SELECT', false, true),
  ('019fa2a1-6ff3-7d69-902f-806f2b8c4460', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6fdb-7e46-84b5-0b300d2c6f6e', 'authenticated', 'SELECT', false, true);


SET session_replication_role TO DEFAULT;


