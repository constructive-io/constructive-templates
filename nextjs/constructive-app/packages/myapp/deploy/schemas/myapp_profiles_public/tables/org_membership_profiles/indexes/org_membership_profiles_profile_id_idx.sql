-- Deploy: schemas/myapp_profiles_public/tables/org_membership_profiles/indexes/org_membership_profiles_profile_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/table
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/columns/profile_id/column


CREATE INDEX org_membership_profiles_profile_id_idx ON myapp_profiles_public.org_membership_profiles USING BTREE ( profile_id );

