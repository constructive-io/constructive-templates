-- Revert: schemas/catalog_private/tables/bindings/columns/is_visible/alterations/alt0000000002


ALTER TABLE catalog_private.bindings 
  ALTER COLUMN is_visible DROP DEFAULT;