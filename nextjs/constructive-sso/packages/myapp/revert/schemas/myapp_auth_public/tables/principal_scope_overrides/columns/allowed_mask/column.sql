-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/allowed_mask/column


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  DROP COLUMN allowed_mask RESTRICT;


