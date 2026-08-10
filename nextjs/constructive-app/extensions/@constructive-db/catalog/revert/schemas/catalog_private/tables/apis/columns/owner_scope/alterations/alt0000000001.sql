-- Revert: schemas/catalog_private/tables/apis/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_private.apis 
  ALTER COLUMN owner_scope DROP NOT NULL;