-- Deploy: schemas/catalog_private/tables/sites_error_pages/columns/site_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_error_pages/columns/site_id/column


COMMENT ON COLUMN catalog_private.sites_error_pages.site_id IS 'Site this error page belongs to (resolver aggregation key propagated from the source row)';