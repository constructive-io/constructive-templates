-- Deploy: schemas/myapp_profiles_public/tables/org_profile_capabilities/columns/capability_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_profile_capabilities/columns/capability_id/column


COMMENT ON COLUMN myapp_profiles_public.org_profile_capabilities.capability_id IS 'References the capability included in this profile';

