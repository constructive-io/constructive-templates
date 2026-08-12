-- Revert: schemas/myapp_profiles_public/tables/org_profile_capabilities/constraints/org_profile_capabilities_profile_id_fkey/constraint


ALTER TABLE myapp_profiles_public.org_profile_capabilities 
  DROP CONSTRAINT org_profile_capabilities_profile_id_fkey;


