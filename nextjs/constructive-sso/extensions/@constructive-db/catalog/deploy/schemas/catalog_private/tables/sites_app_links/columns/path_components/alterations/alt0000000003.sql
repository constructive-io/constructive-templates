-- Deploy: schemas/catalog_private/tables/sites_app_links/columns/path_components/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/columns/path_components/column


COMMENT ON COLUMN catalog_private.sites_app_links.path_components IS 'Path patterns this association applies to, propagated from the source row';