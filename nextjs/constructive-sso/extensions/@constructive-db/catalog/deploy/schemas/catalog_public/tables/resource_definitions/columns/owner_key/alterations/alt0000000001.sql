-- Deploy: schemas/catalog_public/tables/resource_definitions/columns/owner_key/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_definitions/columns/owner_key/column


COMMENT ON COLUMN catalog_public.resource_definitions.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';