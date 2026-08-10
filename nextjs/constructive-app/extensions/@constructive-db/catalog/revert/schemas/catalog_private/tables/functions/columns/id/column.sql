-- Revert: schemas/catalog_private/tables/functions/columns/id/column


ALTER TABLE catalog_private.functions 
  DROP COLUMN id RESTRICT;