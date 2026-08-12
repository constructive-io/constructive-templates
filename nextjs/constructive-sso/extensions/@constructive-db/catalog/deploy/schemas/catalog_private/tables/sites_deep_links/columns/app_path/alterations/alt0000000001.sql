-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/app_path/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/table
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/app_path/column


ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN app_path SET NOT NULL;