-- Verify: schemas/myapp_limits_public/tables/org_limit_events/table/partman


SELECT 1
FROM metaschema_public.partition
WHERE
  table_id = '019feb75-800e-723c-9bc5-bd7ad5ccacf4'::uuid;


