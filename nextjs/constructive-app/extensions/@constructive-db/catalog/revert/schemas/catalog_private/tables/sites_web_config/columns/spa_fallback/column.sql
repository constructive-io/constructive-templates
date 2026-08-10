-- Revert: schemas/catalog_private/tables/sites_web_config/columns/spa_fallback/column


ALTER TABLE catalog_private.sites_web_config 
  DROP COLUMN spa_fallback RESTRICT;