-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/site_id/alterations/alt0000000001


ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN site_id DROP NOT NULL;