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
  ('019fc105-0453-704e-b050-501698bb71a2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-043c-703f-97e3-f65e06053632', 'authenticated', 'SELECT', false, true),
  ('019fc105-046c-7b1f-8a7b-012d2e04540b', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0457-767b-9580-e8e1c84666db', 'authenticated', 'SELECT', false, true),
  ('019fc105-0bdc-74a4-95c6-deb51d17e895', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0bc6-738a-aefc-cde2c076c90b', 'authenticated', 'SELECT', false, true),
  ('019fc105-116a-7e11-b962-21ee94e2b081', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-114e-7a87-a64a-c3691f4580d1', 'authenticated', 'SELECT', false, true),
  ('019fc105-1376-7f4d-b536-5d814fec6fa6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-135e-7fa7-b267-683833e57104', 'authenticated', 'SELECT', false, true);


SET session_replication_role TO DEFAULT;


