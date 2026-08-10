-- Deploy: schemas/myapp_profiles_public/tables/app_profile_definition_grants/columns/capability_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_profile_definition_grants/columns/capability_id/column


COMMENT ON COLUMN myapp_profiles_public.app_profile_definition_grants.capability_id IS E'References the capability that was added to or removed from the profile; NULL if capability was deleted';

