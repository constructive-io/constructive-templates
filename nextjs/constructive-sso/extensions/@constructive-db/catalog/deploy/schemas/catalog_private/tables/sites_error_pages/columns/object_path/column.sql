-- Deploy: schemas/catalog_private/tables/sites_error_pages/columns/object_path/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_error_pages/table


ALTER TABLE catalog_private.sites_error_pages 
  ADD COLUMN object_path text;