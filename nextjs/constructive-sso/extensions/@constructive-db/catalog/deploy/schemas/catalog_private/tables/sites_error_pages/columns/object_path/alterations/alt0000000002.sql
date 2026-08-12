-- Deploy: schemas/catalog_private/tables/sites_error_pages/columns/object_path/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_error_pages/columns/object_path/column


COMMENT ON COLUMN catalog_private.sites_error_pages.object_path IS 'Bucket object served for this status code, propagated from the source row';