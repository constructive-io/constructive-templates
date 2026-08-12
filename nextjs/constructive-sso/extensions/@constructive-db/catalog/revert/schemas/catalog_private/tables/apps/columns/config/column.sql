-- Revert: schemas/catalog_private/tables/apps/columns/config/column


ALTER TABLE catalog_private.apps 
  DROP COLUMN config RESTRICT;