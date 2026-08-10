-- Deploy: schemas/myapp_profiles_public/tables/org_profile_capabilities/policies/enable_row_level_security
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_profile_capabilities/table


ALTER TABLE myapp_profiles_public.org_profile_capabilities 
  ENABLE ROW LEVEL SECURITY;

