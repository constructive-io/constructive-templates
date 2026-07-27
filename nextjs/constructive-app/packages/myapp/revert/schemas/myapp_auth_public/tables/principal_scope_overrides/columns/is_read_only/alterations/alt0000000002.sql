-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/is_read_only/alterations/alt0000000002


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN is_read_only DROP DEFAULT;


