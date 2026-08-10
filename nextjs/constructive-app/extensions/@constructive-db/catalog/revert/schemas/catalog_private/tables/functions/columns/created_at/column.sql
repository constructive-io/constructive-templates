-- Revert: schemas/catalog_private/tables/functions/columns/created_at/column


ALTER TABLE catalog_private.functions 
  DROP COLUMN created_at RESTRICT;