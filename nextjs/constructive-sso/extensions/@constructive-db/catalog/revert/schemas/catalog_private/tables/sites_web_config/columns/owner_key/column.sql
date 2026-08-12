-- Revert: schemas/catalog_private/tables/sites_web_config/columns/owner_key/column


ALTER TABLE catalog_private.sites_web_config 
  DROP COLUMN owner_key RESTRICT;