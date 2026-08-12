-- Revert: schemas/myapp_logging_public/tables/audit_log_auth/table/partman


DELETE FROM metaschema_public.partition
WHERE
  table_id = '019feb75-8da3-75f1-b809-0a4c23d44795'::uuid;


