-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/is_active/column


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  DROP COLUMN is_active RESTRICT;


