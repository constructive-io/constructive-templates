-- Revert: schemas/catalog_private/tables/resources/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_private.resources 
  ALTER COLUMN owner_scope DROP NOT NULL;