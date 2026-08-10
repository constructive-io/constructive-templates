-- Revert: schemas/catalog_private/tables/functions/columns/updated_at/column


ALTER TABLE catalog_private.functions 
  DROP COLUMN updated_at RESTRICT;