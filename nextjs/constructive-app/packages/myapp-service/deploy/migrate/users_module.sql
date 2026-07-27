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
  ('019fa2a1-500d-7302-bee7-f467d2fc2640', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-500d-750e-b14a-d15cb605624f', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'users', '019fa2a1-5065-75d9-bf4c-86d761848b2b', 'role_types', 'auth', NULL);


SET session_replication_role TO DEFAULT;


