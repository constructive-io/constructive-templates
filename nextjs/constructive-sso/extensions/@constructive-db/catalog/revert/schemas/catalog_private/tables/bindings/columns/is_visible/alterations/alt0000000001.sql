-- Revert: schemas/catalog_private/tables/bindings/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_private.bindings 
  ALTER COLUMN is_visible DROP NOT NULL;