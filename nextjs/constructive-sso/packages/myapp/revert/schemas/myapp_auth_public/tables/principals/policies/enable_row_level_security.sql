-- Revert: schemas/myapp_auth_public/tables/principals/policies/enable_row_level_security


ALTER TABLE myapp_auth_public.principals 
  DISABLE ROW LEVEL SECURITY;


