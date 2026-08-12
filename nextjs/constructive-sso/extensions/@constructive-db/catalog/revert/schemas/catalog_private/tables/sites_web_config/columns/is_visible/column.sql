-- Revert: schemas/catalog_private/tables/sites_web_config/columns/is_visible/column


ALTER TABLE catalog_private.sites_web_config 
  DROP COLUMN is_visible RESTRICT;