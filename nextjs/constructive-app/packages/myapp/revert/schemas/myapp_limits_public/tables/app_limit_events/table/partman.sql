-- Revert: schemas/myapp_limits_public/tables/app_limit_events/table/partman


DELETE FROM metaschema_public.partition
WHERE
  table_id = '019fa2a1-52e7-7b9a-83c9-44ece4f9c7a4'::uuid;


