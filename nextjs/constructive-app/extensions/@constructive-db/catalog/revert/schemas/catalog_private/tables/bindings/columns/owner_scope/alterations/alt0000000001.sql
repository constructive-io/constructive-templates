-- Revert: schemas/catalog_private/tables/bindings/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_private.bindings 
  ALTER COLUMN owner_scope DROP NOT NULL;