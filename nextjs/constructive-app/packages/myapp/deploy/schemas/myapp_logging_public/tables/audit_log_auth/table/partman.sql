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
  ('da7dace7-6d94-4f8c-8ae5-016761aacdf5', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8da3-75f1-b809-0a4c23d44795', 'range', '019feb75-8dca-7d44-81b7-54bf97d5e1b2', '1 month', '12 months', TRUE, 2, '{parent}_{bounds}')
ON CONFLICT (table_id) DO NOTHING;

