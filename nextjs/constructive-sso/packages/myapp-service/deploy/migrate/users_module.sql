-- Deploy: migrate/users_module
-- made with <3 @ constructive.io

-- requires: migrate/user_state_module


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

INSERT INTO metaschema_modules_public.users_module (
  id,
  database_id,
  schema_id,
  table_id,
  table_name,
  type_table_id,
  type_table_name,
  api_name,
  private_api_name
) VALUES
  ('019fc104-f2d5-7a11-9482-15645968837d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'users', '019fc104-f348-71f2-afb5-970509c4ca3e', 'role_types', 'auth', NULL);


SET session_replication_role TO DEFAULT;


