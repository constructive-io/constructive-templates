-- Revert: schemas/catalog_private/tables/bindings/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_private.bindings 
  ALTER COLUMN updated_at DROP DEFAULT;