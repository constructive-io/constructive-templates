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
  default_capabilities,
  api_name,
  private_api_name
) VALUES
  ('019feb75-92b4-7459-98ce-cf0a16021cc2', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-92b6-7057-b8de-bd46f3aaef00', '019feb75-92c0-733c-80f8-574ce7b97940', 'storage_public', 'storage_private', '019feb75-92cb-7779-a574-9f45714317cb', '019feb75-9326-7582-bae6-2409b3215b5d', NULL, 'app_buckets', 'app_files', 'app', 'app', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{}', false, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, false, false, false, false, '00:00:30', NULL, '{}', NULL, NULL);


SET session_replication_role TO DEFAULT;


