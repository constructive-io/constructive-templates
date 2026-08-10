-- Revert: schemas/myapp_profiles_public/tables/org_profile_capabilities/columns/created_at/alterations/alt0000000001


ALTER TABLE myapp_profiles_public.org_profile_capabilities 
  ALTER COLUMN created_at DROP DEFAULT;


