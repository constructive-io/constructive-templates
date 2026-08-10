-- Revert: schemas/myapp_profiles_public/tables/app_profile_templates/columns/capabilities/alterations/alt0000000001


ALTER TABLE myapp_profiles_public.app_profile_templates 
  ALTER COLUMN capabilities DROP NOT NULL;


