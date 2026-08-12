-- Deploy: schemas/myapp_profiles_public/tables/app_profiles/columns/capabilities/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_profiles/table


ALTER TABLE myapp_profiles_public.app_profiles 
  ADD COLUMN capabilities bit(64);

