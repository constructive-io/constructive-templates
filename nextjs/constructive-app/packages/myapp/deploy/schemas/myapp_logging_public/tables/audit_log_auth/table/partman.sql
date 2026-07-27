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
  ('b41d33cc-2557-4737-9d65-40a56fb171cf', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-703c-73a4-bcd4-ef0ed194b005', 'range', '019fa2a1-70e7-7803-a305-6394226eb534', '1 month', '12 months', TRUE, 2, '{parent}_{bounds}')
ON CONFLICT (table_id) DO NOTHING;

