-- Deploy: schemas/myapp_capabilities_public/tables/org_capability_defaults/indexes/org_capability_defaults_entity_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capability_defaults/table
-- requires: schemas/myapp_capabilities_public/tables/org_capability_defaults/columns/entity_id/column


CREATE INDEX org_capability_defaults_entity_id_idx ON myapp_capabilities_public.org_capability_defaults USING BTREE ( entity_id );

