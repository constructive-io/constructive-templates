-- Revert: schemas/catalog_private/tables/functions/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_private.functions 
  ALTER COLUMN owner_scope DROP NOT NULL;