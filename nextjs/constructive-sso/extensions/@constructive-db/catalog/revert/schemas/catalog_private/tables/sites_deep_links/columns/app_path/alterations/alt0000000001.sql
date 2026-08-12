-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/app_path/alterations/alt0000000001


ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN app_path DROP NOT NULL;