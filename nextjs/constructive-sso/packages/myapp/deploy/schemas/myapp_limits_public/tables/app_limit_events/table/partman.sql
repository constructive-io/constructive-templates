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
  ('30b478ac-f5e8-4b9a-86f1-74da03867fdc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f604-726c-8678-a802736e11b8', 'range', '019fc104-f61b-76dc-bbec-fedf5db309d4', '1 month', '12 months', TRUE, 2, '{parent}_{bounds}')
ON CONFLICT (table_id) DO NOTHING;

