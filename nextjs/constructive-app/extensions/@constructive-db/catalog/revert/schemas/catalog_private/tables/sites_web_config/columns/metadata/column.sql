-- Revert: schemas/catalog_private/tables/sites_web_config/columns/metadata/column


ALTER TABLE catalog_private.sites_web_config 
  DROP COLUMN metadata RESTRICT;