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
  ('d013e126-7b39-4f1b-b535-f0e202afdcd8', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-d430-750d-8b5e-429956001965', 'range', '019fbc96-d528-7c69-ac6f-bac4f9156c2a', '1 month', '12 months', TRUE, 2, '{parent}_{bounds}')
ON CONFLICT (table_id) DO NOTHING;

