-- Revert: schemas/catalog_private/tables/sites_web_config/columns/updated_at/column


ALTER TABLE catalog_private.sites_web_config 
  DROP COLUMN updated_at RESTRICT;