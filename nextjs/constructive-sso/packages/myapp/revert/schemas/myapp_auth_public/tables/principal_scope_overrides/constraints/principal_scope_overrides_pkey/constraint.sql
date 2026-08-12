-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/constraints/principal_scope_overrides_pkey/constraint


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  DROP CONSTRAINT principal_scope_overrides_pkey;


