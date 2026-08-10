-- Deploy: schemas/myapp_profiles_public/tables/org_membership_profiles/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/table


COMMENT ON TABLE myapp_profiles_public.org_membership_profiles IS E'Every profile a membership holds; memberships.profile_id points at one of them';

