-- Deploy: schemas/catalog_private/tables/sites_app_links/columns/app_identifier/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/columns/app_identifier/column


COMMENT ON COLUMN catalog_private.sites_app_links.app_identifier IS 'App identifier (iOS bundle id or Android package name), propagated from the source row';