-- Revert: schemas/myapp_profiles_public/tables/org_profile_capabilities/columns/id/column


ALTER TABLE myapp_profiles_public.org_profile_capabilities 
  DROP COLUMN id RESTRICT;


