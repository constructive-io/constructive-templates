-- Deploy: migrate/storage_module
-- made with <3 @ constructive.io

-- requires: migrate/sessions_module


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

INSERT INTO metaschema_modules_public.storage_module (
  id,
  database_id,
  schema_id,
  private_schema_id,
  public_schema_name,
  private_schema_name,
  buckets_table_id,
  files_table_id,
  catalog_module_id,
  buckets_table_name,
  files_table_name,
  scope,
  prefix,
  policies,
  provisions,
  entity_table_id,
  entity_field,
  endpoint,
  public_url_prefix,
  provider,
  allowed_origins,
  restrict_reads,
  has_path_shares,
  path_shares_table_id,
  upload_url_expiry_seconds,
  download_url_expiry_seconds,
  default_max_file_size,
  max_filename_length,
  cache_ttl_seconds,
  max_bulk_files,
  max_bulk_total_size,
  has_versioning,
  has_content_hash,
  has_custom_keys,
  has_audit_log,
  has_confirm_upload,
  confirm_upload_delay,
  file_events_table_id,
  default_permissions,
  api_name,
  private_api_name
) VALUES
  ('019fbc96-ded6-75fe-b37f-9d85aad8088f', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ded7-7d8d-9998-193c21acc329', '019fbc96-df2f-79b3-963a-81da5c02e36c', 'storage_public', 'storage_private', '019fbc96-df8c-7b8f-b346-12f61ba2c1ea', '019fbc96-e17f-7451-b63a-298e84a64979', NULL, 'app_buckets', 'app_files', 'app', 'app', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{}', false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, false, false, false, false, '00:00:30', NULL, '{}', NULL, NULL);


SET session_replication_role TO DEFAULT;


