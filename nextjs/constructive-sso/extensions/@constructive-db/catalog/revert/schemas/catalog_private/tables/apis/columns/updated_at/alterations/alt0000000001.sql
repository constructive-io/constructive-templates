-- Revert: schemas/catalog_private/tables/apis/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_private.apis 
  ALTER COLUMN updated_at DROP DEFAULT;