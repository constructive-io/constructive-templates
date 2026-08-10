-- Deploy: schemas/myapp_profiles_public/tables/app_membership_profiles/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/table


GRANT SELECT ON myapp_profiles_public.app_membership_profiles TO authenticated;

