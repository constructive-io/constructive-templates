-- Deploy: schemas/myapp_limits_public/tables/org_limit_events/table/partman
-- made with <3 @ constructive.io

-- requires: schemas/myapp_limits_public/tables/org_limit_events/table


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
  ('74f7cdb1-b5fc-4b4e-a12a-e6dc7b7e605b', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-9731-7e68-81d5-1e8a9e273d88', 'range', '019fbc96-9753-7c74-a977-c33258050050', '1 month', '12 months', TRUE, 2, '{parent}_{bounds}')
ON CONFLICT (table_id) DO NOTHING;

