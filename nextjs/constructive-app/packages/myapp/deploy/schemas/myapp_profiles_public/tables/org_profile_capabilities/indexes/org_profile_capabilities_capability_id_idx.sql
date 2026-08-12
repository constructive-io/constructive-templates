-- Deploy: schemas/myapp_profiles_public/tables/org_profile_capabilities/indexes/org_profile_capabilities_capability_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_profile_capabilities/table
-- requires: schemas/myapp_profiles_public/tables/org_profile_capabilities/columns/capability_id/column


CREATE INDEX org_profile_capabilities_capability_id_idx ON myapp_profiles_public.org_profile_capabilities USING BTREE ( capability_id );

