-- Revert: schemas/myapp_capabilities_public/tables/org_capability_defaults/policies/enable_row_level_security


ALTER TABLE myapp_capabilities_public.org_capability_defaults 
  DISABLE ROW LEVEL SECURITY;


