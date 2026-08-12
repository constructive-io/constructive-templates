-- Deploy: schemas/myapp_profiles_public/tables/app_profile_capabilities/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_profile_capabilities/table
-- requires: schemas/myapp_profiles_public/tables/app_profile_capabilities/columns/updated_at/column


ALTER TABLE myapp_profiles_public.app_profile_capabilities 
  ALTER COLUMN updated_at SET DEFAULT now();

