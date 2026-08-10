-- Revert: schemas/myapp_profiles_public/tables/org_membership_profiles/policies/enable_row_level_security


ALTER TABLE myapp_profiles_public.org_membership_profiles 
  DISABLE ROW LEVEL SECURITY;


