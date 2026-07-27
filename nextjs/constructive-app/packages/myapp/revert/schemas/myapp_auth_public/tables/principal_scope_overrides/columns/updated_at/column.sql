-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/updated_at/column


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  DROP COLUMN updated_at RESTRICT;


