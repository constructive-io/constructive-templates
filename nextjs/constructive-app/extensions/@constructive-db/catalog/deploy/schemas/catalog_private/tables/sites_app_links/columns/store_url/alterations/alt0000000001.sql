-- Deploy: schemas/catalog_private/tables/sites_app_links/columns/store_url/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/columns/store_url/column


COMMENT ON COLUMN catalog_private.sites_app_links.store_url IS 'App/Play store URL, propagated from the source row';