-- Deploy: schemas/myapp_profiles_public/tables/org_profiles/columns/capabilities/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_profiles/columns/capabilities/column


COMMENT ON COLUMN myapp_profiles_public.org_profiles.capabilities IS E'Pre-computed capability bitmask aggregating all capabilities in this profile';

