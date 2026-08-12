-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_grants/indexes/org_capability_default_grants_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_grants/table
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_grants/columns/created_at/column


CREATE INDEX org_capability_default_grants_created_at_idx ON myapp_memberships_public.org_capability_default_grants ( created_at );

