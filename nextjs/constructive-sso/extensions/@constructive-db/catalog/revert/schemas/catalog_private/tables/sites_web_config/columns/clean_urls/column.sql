-- Revert: schemas/catalog_private/tables/sites_web_config/columns/clean_urls/column


ALTER TABLE catalog_private.sites_web_config 
  DROP COLUMN clean_urls RESTRICT;