-- Revert: schemas/myapp_profiles_public/tables/org_profiles/columns/capabilities/column


ALTER TABLE myapp_profiles_public.org_profiles 
  DROP COLUMN capabilities RESTRICT;


