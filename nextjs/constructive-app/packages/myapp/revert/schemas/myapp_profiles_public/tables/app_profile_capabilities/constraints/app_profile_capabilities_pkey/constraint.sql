-- Revert: schemas/myapp_profiles_public/tables/app_profile_capabilities/constraints/app_profile_capabilities_pkey/constraint


ALTER TABLE myapp_profiles_public.app_profile_capabilities 
  DROP CONSTRAINT app_profile_capabilities_pkey;


