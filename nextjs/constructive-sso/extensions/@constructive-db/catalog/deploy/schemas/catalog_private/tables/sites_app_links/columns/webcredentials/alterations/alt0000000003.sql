-- Deploy: schemas/catalog_private/tables/sites_app_links/columns/webcredentials/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/columns/webcredentials/column


COMMENT ON COLUMN catalog_private.sites_app_links.webcredentials IS 'Whether to emit the webcredentials service, propagated from the source row';