-- Revert: schemas/catalog_private/tables/sites_app_links/columns/site_id/alterations/alt0000000001


ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN site_id DROP NOT NULL;