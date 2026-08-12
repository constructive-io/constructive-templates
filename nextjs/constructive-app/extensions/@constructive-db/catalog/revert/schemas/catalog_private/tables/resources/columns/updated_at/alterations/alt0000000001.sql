-- Revert: schemas/catalog_private/tables/resources/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_private.resources 
  ALTER COLUMN updated_at DROP DEFAULT;