-- Deploy: schemas/myapp_profiles_public/tables/org_membership_profiles/columns/profile_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/columns/profile_id/column


COMMENT ON COLUMN myapp_profiles_public.org_membership_profiles.profile_id IS 'References the held profile';

