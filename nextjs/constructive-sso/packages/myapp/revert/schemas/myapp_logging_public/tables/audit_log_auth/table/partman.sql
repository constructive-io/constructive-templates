-- Revert: schemas/myapp_logging_public/tables/audit_log_auth/table/partman


DELETE FROM metaschema_public.partition
WHERE
  table_id = '019fc105-13bf-7b4a-919a-37a5c5871c02'::uuid;


