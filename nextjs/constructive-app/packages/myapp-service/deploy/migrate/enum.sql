-- Deploy: migrate/enum
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

INSERT INTO metaschema_public.enum (
  id,
  database_id,
  schema_id,
  name,
  label,
  description,
  "values",
  smart_tags,
  category,
  tags
) VALUES
  ('019fbc96-e176-7a20-a698-dfd59f378755', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ded7-7d8d-9998-193c21acc329', 'file_status', NULL, 'File lifecycle status: requested (presigned URL generated), uploaded (file in S3), processed (MIME verified, resized, etc.)', '{requested,uploaded,processed}', NULL, 'module', '{}');


SET session_replication_role TO DEFAULT;


