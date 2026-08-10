-- Deploy: schemas/catalog_private/tables/resource_definitions/columns/owner_key/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_definitions/columns/owner_key/column


COMMENT ON COLUMN catalog_private.resource_definitions.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';