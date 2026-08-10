-- Deploy: schemas/catalog_private/tables/sites_app_links/columns/platform/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/columns/platform/column


COMMENT ON COLUMN catalog_private.sites_app_links.platform IS 'Target platform for this association (ios, android), propagated from the source row';