-- Deploy: schemas/catalog_private/tables/resource_installations/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_installations/table


COMMENT ON TABLE catalog_private.resource_installations IS 'Trigger-maintained typed catalog of resource installations across all scopes; UNIQUE (namespace_id, slug)';