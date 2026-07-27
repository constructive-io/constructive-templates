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
  ('e2f4b894-dc76-44e1-8640-76ba07ca957c', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-52e7-7b9a-83c9-44ece4f9c7a4', 'range', '019fa2a1-52fc-7668-a55d-2047dbb14fec', '1 month', '12 months', TRUE, 2, '{parent}_{bounds}')
ON CONFLICT (table_id) DO NOTHING;

