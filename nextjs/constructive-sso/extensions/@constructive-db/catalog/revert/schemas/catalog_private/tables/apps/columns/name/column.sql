-- Revert: schemas/catalog_private/tables/apps/columns/name/column


ALTER TABLE catalog_private.apps 
  DROP COLUMN name RESTRICT;