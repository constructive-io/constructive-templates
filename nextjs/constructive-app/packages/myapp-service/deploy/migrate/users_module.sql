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
  ('019feb75-78d6-79a8-a137-4257d3c10db4', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78d6-7cd0-9533-31bd8de066b8', '019feb75-78e2-720e-82dc-c3ed84264ce8', 'users', '019feb75-7911-7db8-a88d-ce102149bb22', 'role_types', 'auth', NULL);


SET session_replication_role TO DEFAULT;


