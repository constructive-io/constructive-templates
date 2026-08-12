-- Deploy: migrate/rate_limits_module
-- made with <3 @ constructive.io

-- requires: migrate/principal_auth_module


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
  ('019fc105-0509-77de-b320-133456184a90', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-fee2-7758-ae40-4fdc60702a9e', '019fc105-0509-7e23-bf8c-4957678ad39c', '019fc105-0611-7e5d-8c39-47e53c2a80d2', '019fc105-06bc-74e6-9286-763950a36e86', 'app_settings_rate_limit', 'auth_ip_rate_limits', 'auth_rate_limits');


SET session_replication_role TO DEFAULT;


