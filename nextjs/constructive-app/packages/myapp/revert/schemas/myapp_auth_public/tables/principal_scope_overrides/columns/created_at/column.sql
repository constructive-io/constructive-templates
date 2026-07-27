-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/created_at/column


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  DROP COLUMN created_at RESTRICT;


