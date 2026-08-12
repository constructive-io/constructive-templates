-- Revert: schemas/catalog_private/tables/bindings/columns/lifecycle/alterations/alt0000000001


ALTER TABLE catalog_private.bindings 
  ALTER COLUMN lifecycle DROP NOT NULL;