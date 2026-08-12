-- Deploy: schemas/catalog_private/tables/sites_error_pages/columns/is_visible/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_error_pages/table


ALTER TABLE catalog_private.sites_error_pages 
  ADD COLUMN is_visible boolean;