-- Deploy: schemas/catalog_private/tables/resource_definitions/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_definitions/table


COMMENT ON TABLE catalog_private.resource_definitions IS 'Trigger-maintained typed catalog of resource definitions across all scopes; UNIQUE (namespace_id, kind, slug)';