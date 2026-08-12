-- Revert: schemas/catalog_private/tables/sites_web_config/columns/site_id/alterations/alt0000000001


ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN site_id DROP NOT NULL;