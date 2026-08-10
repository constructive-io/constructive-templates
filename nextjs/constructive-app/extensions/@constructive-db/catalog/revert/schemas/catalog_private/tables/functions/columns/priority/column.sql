-- Revert: schemas/catalog_private/tables/functions/columns/priority/column


ALTER TABLE catalog_private.functions 
  DROP COLUMN priority RESTRICT;