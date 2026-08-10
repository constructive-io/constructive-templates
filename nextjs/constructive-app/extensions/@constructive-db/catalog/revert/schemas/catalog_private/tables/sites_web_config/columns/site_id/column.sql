-- Revert: schemas/catalog_private/tables/sites_web_config/columns/site_id/column


ALTER TABLE catalog_private.sites_web_config 
  DROP COLUMN site_id RESTRICT;