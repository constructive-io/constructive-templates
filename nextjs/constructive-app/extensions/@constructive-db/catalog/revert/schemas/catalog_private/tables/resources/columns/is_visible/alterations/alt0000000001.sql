-- Revert: schemas/catalog_private/tables/resources/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_private.resources 
  ALTER COLUMN is_visible DROP NOT NULL;