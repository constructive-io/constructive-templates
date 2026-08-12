-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/is_visible/alterations/alt0000000002


ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN is_visible DROP DEFAULT;