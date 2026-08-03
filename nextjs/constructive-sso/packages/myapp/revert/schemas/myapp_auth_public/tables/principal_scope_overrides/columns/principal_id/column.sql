-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/principal_id/column


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  DROP COLUMN principal_id RESTRICT;


