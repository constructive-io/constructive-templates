-- Revert: schemas/myapp_limits_public/tables/org_limit_events/table/partman


DELETE FROM metaschema_public.partition
WHERE
  table_id = '019fbc96-9731-7e68-81d5-1e8a9e273d88'::uuid;


