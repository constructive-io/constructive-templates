-- Revert: schemas/myapp_auth_private/tables/identity_providers/policies/enable_row_level_security


ALTER TABLE myapp_auth_private.identity_providers 
  DISABLE ROW LEVEL SECURITY;


