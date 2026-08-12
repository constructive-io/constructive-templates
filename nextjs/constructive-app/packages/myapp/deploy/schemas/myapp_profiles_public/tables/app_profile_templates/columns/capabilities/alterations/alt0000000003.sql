-- Deploy: schemas/myapp_profiles_public/tables/app_profile_templates/columns/capabilities/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_profile_templates/columns/capabilities/column


COMMENT ON COLUMN myapp_profiles_public.app_profile_templates.capabilities IS E'Pre-computed capability bitmask for the seeded profile';

