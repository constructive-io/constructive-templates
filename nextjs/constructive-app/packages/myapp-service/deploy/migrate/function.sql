-- Deploy: migrate/function
-- made with <3 @ constructive.io

-- requires: migrate/default_privilege


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

INSERT INTO metaschema_public.function (
  id,
  database_id,
  schema_id,
  name
) VALUES
  ('019fa2a1-693d-7319-acdd-6b3cb37d32cc', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'authenticate'),
  ('019fa2a1-693d-7d66-9dc4-264de36f3f9c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5b92-7e43-b110-f1d39bc5ee19', 'authenticate_strict'),
  ('019fa2a1-693e-7618-9e7f-71279c10a1fa', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'current_user'),
  ('019fa2a1-693e-7ea8-abfa-61083c752dba', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'current_user_id'),
  ('019fa2a1-693f-7743-83ab-09ebe35e414f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'current_user_agent'),
  ('019fa2a1-693f-7f8d-8c55-8bab4e44afad', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', 'current_ip_address');


SET session_replication_role TO DEFAULT;


