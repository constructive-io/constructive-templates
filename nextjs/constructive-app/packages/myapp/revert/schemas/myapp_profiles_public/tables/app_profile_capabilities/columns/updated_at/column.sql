-- Revert: schemas/myapp_profiles_public/tables/app_profile_capabilities/columns/updated_at/column


ALTER TABLE myapp_profiles_public.app_profile_capabilities 
  DROP COLUMN updated_at RESTRICT;


