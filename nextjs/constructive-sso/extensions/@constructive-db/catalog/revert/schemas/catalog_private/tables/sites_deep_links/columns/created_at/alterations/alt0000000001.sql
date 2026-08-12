-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN created_at DROP DEFAULT;