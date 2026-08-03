-- Deploy: schemas/myapp_limits_public/tables/app_limit_events/table/partman
-- made with <3 @ constructive.io

-- requires: schemas/myapp_limits_public/tables/app_limit_events/table


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
  ('05bfa191-c0fb-424e-b4d9-a2a9a9a6137d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8810-7f7a-8805-483397318795', 'range', '019fbc96-8825-7bc3-a3a5-10962f5132d2', '1 month', '12 months', TRUE, 2, '{parent}_{bounds}')
ON CONFLICT (table_id) DO NOTHING;

