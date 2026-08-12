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
  ('3f63e079-7e48-437a-adee-d97bcc972d24', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-800e-723c-9bc5-bd7ad5ccacf4', 'range', '019feb75-801a-74b4-a1e6-806827b59d42', '1 month', '12 months', TRUE, 2, '{parent}_{bounds}')
ON CONFLICT (table_id) DO NOTHING;

