-- Revert: schemas/myapp_limits_public/tables/app_limit_events/table/partman


DELETE FROM metaschema_public.partition
WHERE
  table_id = '019fbc96-8810-7f7a-8805-483397318795'::uuid;


