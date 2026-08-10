-- Revert: schemas/catalog_private/tables/bindings/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_private.bindings 
  ALTER COLUMN database_id DROP NOT NULL;