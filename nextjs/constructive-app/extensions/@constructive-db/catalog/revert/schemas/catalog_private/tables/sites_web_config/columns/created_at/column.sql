-- Revert: schemas/catalog_private/tables/sites_web_config/columns/created_at/column


ALTER TABLE catalog_private.sites_web_config 
  DROP COLUMN created_at RESTRICT;