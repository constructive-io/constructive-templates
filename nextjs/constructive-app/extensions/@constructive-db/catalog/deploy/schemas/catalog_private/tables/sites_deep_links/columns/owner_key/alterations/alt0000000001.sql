-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/owner_key/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/owner_key/column


COMMENT ON COLUMN catalog_private.sites_deep_links.owner_key IS 'Value of the source table scope key column; NULL for global-tier owners';