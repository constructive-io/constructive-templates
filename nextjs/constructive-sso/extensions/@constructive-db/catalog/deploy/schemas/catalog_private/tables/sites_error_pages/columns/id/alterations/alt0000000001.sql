-- Deploy: schemas/catalog_private/tables/sites_error_pages/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_error_pages/table
-- requires: schemas/catalog_private/tables/sites_error_pages/columns/id/column


ALTER TABLE catalog_private.sites_error_pages 
  ALTER COLUMN id SET NOT NULL;