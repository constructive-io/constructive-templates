-- Deploy: schemas/myapp_profiles_public/tables/app_profile_capabilities/constraints/app_profile_capabilities_capability_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/table
-- requires: schemas/myapp_profiles_public/tables/app_profile_capabilities/table


ALTER TABLE myapp_profiles_public.app_profile_capabilities 
  ADD CONSTRAINT app_profile_capabilities_capability_id_fkey 
    FOREIGN KEY(capability_id) 
    REFERENCES myapp_capabilities_public.app_capabilities (id) 
    ON DELETE CASCADE;

