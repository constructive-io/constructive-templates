-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/policies/enable_row_level_security


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  DISABLE ROW LEVEL SECURITY;


