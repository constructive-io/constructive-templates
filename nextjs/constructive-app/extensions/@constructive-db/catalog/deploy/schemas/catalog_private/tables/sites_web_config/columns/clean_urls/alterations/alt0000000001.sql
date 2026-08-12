-- Deploy: schemas/catalog_private/tables/sites_web_config/columns/clean_urls/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_web_config/columns/clean_urls/column


COMMENT ON COLUMN catalog_private.sites_web_config.clean_urls IS 'Extensionless path resolution flag propagated from the source row (NULL = gateway default)';