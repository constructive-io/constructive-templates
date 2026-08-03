-- Revert: schemas/myapp_logging_public/tables/audit_log_auth/table/partman


DELETE FROM metaschema_public.partition
WHERE
  table_id = '019fbc96-d430-750d-8b5e-429956001965'::uuid;


