-- Revert: schemas/catalog_private/tables/bindings/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.bindings 
  ALTER COLUMN created_at DROP DEFAULT;