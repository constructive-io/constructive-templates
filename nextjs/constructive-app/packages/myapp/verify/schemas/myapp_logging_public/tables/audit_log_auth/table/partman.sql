-- Verify: schemas/myapp_logging_public/tables/audit_log_auth/table/partman


SELECT 1
FROM metaschema_public.partition
WHERE
  table_id = '019fa2a1-703c-73a4-bcd4-ef0ed194b005'::uuid;


