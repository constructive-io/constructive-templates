-- Deploy: migrate/rate_limits_module
-- made with <3 @ constructive.io

-- requires: migrate/profiles_module


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

INSERT INTO metaschema_modules_public.rate_limits_module (
  id,
  database_id,
  schema_id,
  rate_limit_settings_table_id,
  ip_rate_limits_table_id,
  rate_limits_table_id,
  rate_limit_settings_table_name,
  ip_rate_limits_table_name,
  rate_limits_table_name
) VALUES
  ('019fbc96-b75f-7d24-8f86-ac503a0871bb', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ae06-75fc-96c3-df2484d13ce6', '019fbc96-b760-738f-a87f-3b906bd93536', '019fbc96-b8f2-702a-b172-48e604ef0185', '019fbc96-b9e0-730a-84ef-3247bb074a9a', 'app_settings_rate_limit', 'auth_ip_rate_limits', 'auth_rate_limits');


SET session_replication_role TO DEFAULT;


