-- Revert: schemas/catalog_private/tables/resources/columns/kind/alterations/alt0000000001


ALTER TABLE catalog_private.resources 
  ALTER COLUMN kind DROP NOT NULL;