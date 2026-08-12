-- Revert: schemas/myapp_profiles_public/tables/org_profiles/columns/capabilities/alterations/alt0000000002


ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN capabilities DROP DEFAULT;


