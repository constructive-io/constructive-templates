-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/policies/enable_row_level_security


ALTER TABLE myapp_capabilities_public.app_capabilities 
  DISABLE ROW LEVEL SECURITY;


