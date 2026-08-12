-- Deploy: schemas/myapp_profiles_public/tables/org_profile_capabilities/columns/created_at/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_profile_capabilities/table


ALTER TABLE myapp_profiles_public.org_profile_capabilities 
  ADD COLUMN created_at timestamptz;

