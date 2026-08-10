-- Revert: schemas/catalog_private/tables/sites_web_config/columns/index_document/column


ALTER TABLE catalog_private.sites_web_config 
  DROP COLUMN index_document RESTRICT;