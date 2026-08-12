-- Deploy: schemas/myapp_profiles_public/tables/app_profile_capabilities/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_profile_capabilities/table
-- requires: schemas/myapp_profiles_public/tables/app_profile_capabilities/columns/id/column


ALTER TABLE myapp_profiles_public.app_profile_capabilities 
  ALTER COLUMN id SET DEFAULT uuidv7();

