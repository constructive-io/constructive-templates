-- Deploy: schemas/catalog_private/tables/sites_web_config/columns/index_document/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_web_config/columns/index_document/column


COMMENT ON COLUMN catalog_private.sites_web_config.index_document IS 'Default object served for directory-style requests, propagated from the source row';