-- Revert: schemas/catalog_private/tables/bindings/columns/key/alterations/alt0000000001


ALTER TABLE catalog_private.bindings 
  ALTER COLUMN key DROP NOT NULL;