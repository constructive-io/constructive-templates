-- Deploy: schemas/myapp_profiles_public/tables/app_membership_profiles/columns/actor_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/columns/actor_id/column


COMMENT ON COLUMN myapp_profiles_public.app_membership_profiles.actor_id IS E'References the user holding the profile, denormalised from the membership';

