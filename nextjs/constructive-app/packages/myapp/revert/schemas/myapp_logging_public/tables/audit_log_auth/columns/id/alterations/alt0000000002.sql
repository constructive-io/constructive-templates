-- Revert: schemas/myapp_logging_public/tables/audit_log_auth/columns/id/alterations/alt0000000002


ALTER TABLE myapp_logging_public.audit_log_auth 
  ALTER COLUMN id DROP DEFAULT;


