-- Revert: schemas/catalog_private/tables/sites_web_config/columns/database_id/column


ALTER TABLE catalog_private.sites_web_config 
  DROP COLUMN database_id RESTRICT;