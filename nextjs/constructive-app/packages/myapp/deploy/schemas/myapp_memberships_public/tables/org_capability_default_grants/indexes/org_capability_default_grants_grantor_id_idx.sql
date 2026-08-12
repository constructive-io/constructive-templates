-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_grants/indexes/org_capability_default_grants_grantor_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_grants/table
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_grants/columns/grantor_id/column


CREATE INDEX org_capability_default_grants_grantor_id_idx ON myapp_memberships_public.org_capability_default_grants USING BTREE ( grantor_id );

