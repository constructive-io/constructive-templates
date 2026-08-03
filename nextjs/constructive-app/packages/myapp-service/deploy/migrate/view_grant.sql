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
  ('019fbc96-b65a-79ab-ace4-0fe6cdabb823', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b639-7c4f-8e7c-744b5346ac1e', 'authenticated', 'SELECT', false, true),
  ('019fbc96-b67e-7295-b13a-bd5482335bb9', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b660-7cc4-977a-e31b757ef8b2', 'authenticated', 'SELECT', false, true),
  ('019fbc96-c0d9-7abd-829b-4797768dae34', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c0ba-7f88-a2dc-e9e346eb1902', 'authenticated', 'SELECT', false, true),
  ('019fbc96-c885-7694-a172-523202c83b2d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c862-701b-9ee6-d65f38de3b9a', 'authenticated', 'SELECT', false, true),
  ('019fbc96-cb53-7cec-88c9-a0f4508e4893', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cb2f-7488-a3f5-e0f742bd511e', 'authenticated', 'SELECT', false, true),
  ('019fbc96-dde1-73ae-9aa6-874ac6c05e95', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ddb8-785f-9297-c8f1a1540c35', 'authenticated', 'SELECT', false, true);


SET session_replication_role TO DEFAULT;


