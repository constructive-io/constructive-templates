-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/membership_type/column


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  DROP COLUMN membership_type RESTRICT;


