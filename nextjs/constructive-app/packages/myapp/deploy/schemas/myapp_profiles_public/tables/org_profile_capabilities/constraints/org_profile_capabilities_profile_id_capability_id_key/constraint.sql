-- Deploy: schemas/myapp_profiles_public/tables/org_profile_capabilities/constraints/org_profile_capabilities_profile_id_capability_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_profile_capabilities/table


ALTER TABLE myapp_profiles_public.org_profile_capabilities 
  ADD CONSTRAINT org_profile_capabilities_profile_id_capability_id_key 
    UNIQUE (profile_id, capability_id);

