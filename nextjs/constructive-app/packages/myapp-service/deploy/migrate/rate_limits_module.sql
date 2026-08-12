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
  ('019feb75-880d-7713-9905-d71e936d3c5f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8695-7e24-8b0b-8db166cbaf4a', '019feb75-880d-7cf9-99a9-511154d59d7f', '019feb75-8846-7b3d-84c7-196f76f0ae39', '019feb75-886c-70f1-ac1c-d171bba694aa', 'app_settings_rate_limit', 'auth_ip_rate_limits', 'auth_rate_limits');


SET session_replication_role TO DEFAULT;


