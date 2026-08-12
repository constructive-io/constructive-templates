-- Revert: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/policies/enable_row_level_security


ALTER TABLE myapp_memberships_public.org_capability_default_capabilities 
  DISABLE ROW LEVEL SECURITY;


