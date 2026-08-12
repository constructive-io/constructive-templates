-- Deploy: schemas/catalog_private/tables/sites_error_pages/columns/status_code/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_error_pages/columns/status_code/column


COMMENT ON COLUMN catalog_private.sites_error_pages.status_code IS 'HTTP status code this custom page is served for, propagated from the source row';