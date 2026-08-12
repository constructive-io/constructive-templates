-- Deploy: schemas/myapp_profiles_public/tables/app_profile_capabilities/constraints/app_profile_capabilities_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_profile_capabilities/table


ALTER TABLE myapp_profiles_public.app_profile_capabilities 
  ADD CONSTRAINT app_profile_capabilities_pkey PRIMARY KEY (id);

