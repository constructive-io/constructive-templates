-- Deploy: schemas/myapp_profiles_public/tables/app_membership_profiles/indexes/app_membership_profiles_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/table
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/columns/updated_at/column


CREATE INDEX app_membership_profiles_updated_at_idx ON myapp_profiles_public.app_membership_profiles ( updated_at );

