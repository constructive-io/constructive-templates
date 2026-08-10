-- Deploy: schemas/myapp_memberships_public/tables/app_capability_default_grants/indexes/app_capability_default_grants_capability_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_grants/table
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_grants/columns/capability_id/column


CREATE INDEX app_capability_default_grants_capability_id_idx ON myapp_memberships_public.app_capability_default_grants USING BTREE ( capability_id );

