-- Deploy: migrate/user_credentials_module
-- made with <3 @ constructive.io

-- requires: migrate/user_auth_module


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

INSERT INTO metaschema_modules_public.user_credentials_module (
  id,
  database_id,
  entity_field,
  schema_id,
  table_id,
  table_name,
  private_api_name
) VALUES
  ('019fa2a1-6661-7059-8619-4848dca01e9e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'owner_id', '019fa2a1-5af9-72d1-8fba-f96774dd90ce', '019fa2a1-6661-7502-b1a4-7ebfccb37ee9', 'user_secrets', NULL);


SET session_replication_role TO DEFAULT;


