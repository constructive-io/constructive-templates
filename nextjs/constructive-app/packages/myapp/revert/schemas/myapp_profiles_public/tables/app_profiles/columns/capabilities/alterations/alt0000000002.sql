-- Revert: schemas/myapp_profiles_public/tables/app_profiles/columns/capabilities/alterations/alt0000000002


ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN capabilities DROP DEFAULT;


