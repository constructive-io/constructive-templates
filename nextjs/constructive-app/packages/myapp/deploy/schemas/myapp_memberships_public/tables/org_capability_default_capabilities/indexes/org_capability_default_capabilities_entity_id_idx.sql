-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/indexes/org_capability_default_capabilities_entity_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/table
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/columns/entity_id/column


CREATE INDEX org_capability_default_capabilities_entity_id_idx ON myapp_memberships_public.org_capability_default_capabilities USING BTREE ( entity_id );

