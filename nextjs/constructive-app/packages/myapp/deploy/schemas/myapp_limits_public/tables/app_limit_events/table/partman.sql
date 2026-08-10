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
  ('6ec51118-e5bd-4744-bc2b-4a0d28c1f479', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-7a56-789b-b3c7-a2b7134c8406', 'range', '019feb75-7a60-7c24-ace5-e232d1139d1e', '1 month', '12 months', TRUE, 2, '{parent}_{bounds}')
ON CONFLICT (table_id) DO NOTHING;

