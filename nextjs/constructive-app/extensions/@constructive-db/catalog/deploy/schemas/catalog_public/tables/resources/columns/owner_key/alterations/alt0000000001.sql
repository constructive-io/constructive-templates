-- Deploy: schemas/catalog_public/tables/resources/columns/owner_key/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/columns/owner_key/column


COMMENT ON COLUMN catalog_public.resources.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';