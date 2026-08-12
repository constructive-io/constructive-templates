-- Revert: schemas/myapp_profiles_public/tables/app_membership_profiles/policies/enable_row_level_security


ALTER TABLE myapp_profiles_public.app_membership_profiles 
  DISABLE ROW LEVEL SECURITY;


