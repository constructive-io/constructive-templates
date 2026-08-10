-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/fallback_url/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/fallback_url/column


COMMENT ON COLUMN catalog_private.sites_deep_links.fallback_url IS 'Absolute external fallback URL, propagated from the source row';