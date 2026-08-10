-- Revert: schemas/catalog_private/tables/functions/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_private.functions 
  ALTER COLUMN is_visible DROP NOT NULL;