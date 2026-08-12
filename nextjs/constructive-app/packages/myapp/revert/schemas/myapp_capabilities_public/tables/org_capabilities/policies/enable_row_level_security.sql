-- Revert: schemas/myapp_capabilities_public/tables/org_capabilities/policies/enable_row_level_security


ALTER TABLE myapp_capabilities_public.org_capabilities 
  DISABLE ROW LEVEL SECURITY;


