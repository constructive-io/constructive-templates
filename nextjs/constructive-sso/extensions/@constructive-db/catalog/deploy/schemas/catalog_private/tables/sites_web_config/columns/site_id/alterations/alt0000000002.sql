-- Deploy: schemas/catalog_private/tables/sites_web_config/columns/site_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_web_config/columns/site_id/column


COMMENT ON COLUMN catalog_private.sites_web_config.site_id IS 'Site this configuration belongs to (resolver join key propagated from the source row)';