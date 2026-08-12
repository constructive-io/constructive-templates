-- Revert: schemas/myapp_profiles_public/tables/org_profile_capabilities/columns/capability_id/column


ALTER TABLE myapp_profiles_public.org_profile_capabilities 
  DROP COLUMN capability_id RESTRICT;


