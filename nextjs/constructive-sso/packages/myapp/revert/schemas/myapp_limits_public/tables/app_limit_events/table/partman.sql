-- Revert: schemas/myapp_limits_public/tables/app_limit_events/table/partman


DELETE FROM metaschema_public.partition
WHERE
  table_id = '019fc104-f604-726c-8678-a802736e11b8'::uuid;


