-- Revert: schemas/myapp_profiles_public/tables/app_profile_capabilities/columns/capability_id/column


ALTER TABLE myapp_profiles_public.app_profile_capabilities 
  DROP COLUMN capability_id RESTRICT;


