-- Deploy: schemas/myapp_logging_public/tables/audit_log_auth/table/partman
-- made with <3 @ constructive.io

-- requires: schemas/myapp_logging_public/tables/audit_log_auth/table


INSERT INTO metaschema_public.partition (
  id,
  database_id,
  table_id,
  strategy,
  partition_key_id,
  interval,
  retention,
  retention_keep_table,
  premake,
  naming_pattern
)
VALUES
  ('60357c79-f063-41e8-b654-bc2e13d30b39', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-13bf-7b4a-919a-37a5c5871c02', 'range', '019fc105-147a-7664-ab8d-cb5ade70c20c', '1 month', '12 months', TRUE, 2, '{parent}_{bounds}')
ON CONFLICT (table_id) DO NOTHING;

