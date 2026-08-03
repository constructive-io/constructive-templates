-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/use_admin_owner/column


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  DROP COLUMN use_admin_owner RESTRICT;


