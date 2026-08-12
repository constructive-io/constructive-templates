-- Revert: schemas/catalog_private/tables/resources/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.resources 
  ALTER COLUMN created_at DROP DEFAULT;