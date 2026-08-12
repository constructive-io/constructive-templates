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
  ('019fc105-0c8c-705e-a214-e46e99b95efe', '019fc104-fee2-7758-ae40-4fdc60702a9e', '019fc105-0c1b-7bde-9736-c30b1029bcc9', '019fc105-0c87-759a-8dfd-02ea5cda1fe6', '019fc105-0c88-7127-840c-f1990809df78', '019fc105-0c88-7ab7-a4eb-42500e3c6947', '019fc105-0c89-7435-82c2-6c0aea68b473', '019fc105-0c89-7d91-b304-1c644351e053', '019fc105-0c8a-7757-9bf5-55c5ae96fefa', '019fc104-f28d-7b9c-8d9d-8f338def573c');


SET session_replication_role TO DEFAULT;


