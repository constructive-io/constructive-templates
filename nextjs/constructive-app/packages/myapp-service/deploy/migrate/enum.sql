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
  ('019feb75-92ed-7ced-9de5-2d567b43070e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92b6-7057-b8de-bd46f3aaef00', 'bucket_type', NULL, 'Bucket access kind: public (CDN-served), private (presigned GET), temp (staging uploads)', '{public,private,temp}', NULL, 'module', '{}'),
  ('019feb75-9325-71d6-91ae-86b7dc44a7e6', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92b6-7057-b8de-bd46f3aaef00', 'file_status', NULL, 'File lifecycle status: requested (presigned URL generated), uploaded (file in S3, validated), processed (resized, extracted, etc.), rejected (content failed validation), expired (bytes never arrived)', '{requested,uploaded,processed,rejected,expired}', NULL, 'module', '{}');


SET session_replication_role TO DEFAULT;


