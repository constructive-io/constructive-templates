-- Revert: schemas/myapp_profiles_public/tables/app_profile_capabilities/columns/id/column


ALTER TABLE myapp_profiles_public.app_profile_capabilities 
  DROP COLUMN id RESTRICT;


