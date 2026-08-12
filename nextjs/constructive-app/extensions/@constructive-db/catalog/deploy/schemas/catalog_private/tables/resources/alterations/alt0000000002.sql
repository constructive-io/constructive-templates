-- Deploy: schemas/catalog_private/tables/resources/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/table


COMMENT ON TABLE catalog_private.resources IS 'Trigger-maintained typed catalog of resources across all scopes; UNIQUE (namespace_id, kind, slug)';