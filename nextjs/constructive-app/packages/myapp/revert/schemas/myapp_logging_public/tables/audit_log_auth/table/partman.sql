-- Revert: schemas/myapp_logging_public/tables/audit_log_auth/table/partman


DELETE FROM metaschema_public.partition
WHERE
  table_id = '019fa2a1-703c-73a4-bcd4-ef0ed194b005'::uuid;


