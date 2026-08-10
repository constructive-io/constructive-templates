-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/slug/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/slug/column


COMMENT ON COLUMN catalog_private.sites_deep_links.slug IS 'Link name unique per site, propagated from the source row';