-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/site_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/site_id/column


COMMENT ON COLUMN catalog_private.sites_deep_links.site_id IS 'Site this deep link belongs to (serving-edge lookup key propagated from the source row)';