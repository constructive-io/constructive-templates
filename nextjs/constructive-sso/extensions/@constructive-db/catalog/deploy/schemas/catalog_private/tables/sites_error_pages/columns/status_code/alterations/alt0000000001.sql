-- Deploy: schemas/catalog_private/tables/sites_error_pages/columns/status_code/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_error_pages/table
-- requires: schemas/catalog_private/tables/sites_error_pages/columns/status_code/column


ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN status_code SET NOT NULL;