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
  ('019fbc96-c1c3-708e-9563-1091c8754a6e', '019fbc96-ae06-75fc-96c3-df2484d13ce6', '019fbc96-c130-7558-9bec-78482a963cfe', '019fbc96-c1bb-7879-8017-2e2e641162e8', '019fbc96-c1bc-7a08-9f4c-1d8d09cb642d', '019fbc96-c1bd-79da-892e-8cd5eca09e33', '019fbc96-c1be-79b7-87b6-488196d15260', '019fbc96-c1bf-792e-a755-3bfaba37f1c2', '019fbc96-c1c0-78ec-abd7-23cd8c34518c', '019fbc96-84d8-7d13-8acc-4c55ad35634c');


SET session_replication_role TO DEFAULT;


