-- Revert: schemas/myapp_auth_public/tables/principal_entities/policies/enable_row_level_security


ALTER TABLE myapp_auth_public.principal_entities 
  DISABLE ROW LEVEL SECURITY;


