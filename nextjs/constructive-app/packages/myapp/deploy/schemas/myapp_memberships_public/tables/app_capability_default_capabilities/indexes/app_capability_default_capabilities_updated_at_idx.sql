-- Deploy: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/indexes/app_capability_default_capabilities_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/table
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/columns/updated_at/column


CREATE INDEX app_capability_default_capabilities_updated_at_idx ON myapp_memberships_public.app_capability_default_capabilities ( updated_at );

