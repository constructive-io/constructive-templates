-- Revert: schemas/myapp_profiles_public/tables/app_profile_capabilities/columns/id/alterations/alt0000000001


ALTER TABLE myapp_profiles_public.app_profile_capabilities 
  ALTER COLUMN id DROP NOT NULL;


