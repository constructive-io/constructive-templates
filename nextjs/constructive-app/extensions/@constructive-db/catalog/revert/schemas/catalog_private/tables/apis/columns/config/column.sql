-- Revert: schemas/catalog_private/tables/apis/columns/config/column


ALTER TABLE catalog_private.apis 
  DROP COLUMN config RESTRICT;