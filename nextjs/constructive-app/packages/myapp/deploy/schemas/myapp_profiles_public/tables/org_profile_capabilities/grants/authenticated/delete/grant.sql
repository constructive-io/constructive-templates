-- Deploy: schemas/myapp_profiles_public/tables/org_profile_capabilities/grants/authenticated/delete/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_profile_capabilities/table


GRANT DELETE ON myapp_profiles_public.org_profile_capabilities TO authenticated;

