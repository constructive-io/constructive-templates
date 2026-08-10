-- Revert: schemas/myapp_limits_public/tables/app_limit_events/table/partman


DELETE FROM metaschema_public.partition
WHERE
  table_id = '019feb75-7a56-789b-b3c7-a2b7134c8406'::uuid;


