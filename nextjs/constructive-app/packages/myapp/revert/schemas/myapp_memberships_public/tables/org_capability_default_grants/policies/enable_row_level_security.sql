-- Revert: schemas/myapp_memberships_public/tables/org_capability_default_grants/policies/enable_row_level_security


ALTER TABLE myapp_memberships_public.org_capability_default_grants 
  DISABLE ROW LEVEL SECURITY;


