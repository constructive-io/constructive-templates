-- Revert: schemas/myapp_profiles_public/tables/app_profile_capabilities/policies/enable_row_level_security


ALTER TABLE myapp_profiles_public.app_profile_capabilities 
  DISABLE ROW LEVEL SECURITY;


