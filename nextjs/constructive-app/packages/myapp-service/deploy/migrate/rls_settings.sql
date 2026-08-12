-- Deploy: migrate/rls_settings
-- made with <3 @ constructive.io

-- requires: migrate/domains


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

INSERT INTO routing_public.rls_settings (
  id,
  authenticate_schema_id,
  role_schema_id,
  authenticate_function_id,
  authenticate_strict_function_id,
  current_role_function_id,
  current_role_id_function_id,
  current_user_agent_function_id,
  current_ip_address_function_id,
  database_id
) VALUES
  ('019feb75-8a0d-7e34-86e7-d090dde6fa86', '019feb75-8695-7e24-8b0b-8db166cbaf4a', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', '019feb75-8a0c-7e1c-8bf7-927d06c61034', '019feb75-8a0d-70f9-929a-f77c897775da', '019feb75-8a0d-71eb-b4e3-4bc704a95f36', '019feb75-8a0d-7351-93fa-5bf52714a65e', '019feb75-8a0d-7415-a353-3c78b8d93d0a', '019feb75-8a0d-74cf-83b2-ccaf7362a0d9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6');


SET session_replication_role TO DEFAULT;


