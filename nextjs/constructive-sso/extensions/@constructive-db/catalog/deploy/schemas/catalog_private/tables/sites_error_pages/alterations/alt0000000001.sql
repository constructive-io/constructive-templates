-- Deploy: schemas/catalog_private/tables/sites_error_pages/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_error_pages/table


ALTER TABLE catalog_private.sites_error_pages 
  DISABLE ROW LEVEL SECURITY;