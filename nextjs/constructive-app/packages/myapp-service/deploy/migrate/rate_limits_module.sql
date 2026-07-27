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
  ('019fa2a1-61d6-78ab-8566-7663e760de6e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', '019fa2a1-61d6-7dff-876e-13802d91c7ec', '019fa2a1-62f0-7b99-aea9-87eac6e5fe19', '019fa2a1-639b-7ad6-b70a-a9e79a494ed0', 'app_settings_rate_limit', 'auth_ip_rate_limits', 'auth_rate_limits');


SET session_replication_role TO DEFAULT;


