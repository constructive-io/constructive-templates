-- Revert: schemas/catalog_private/tables/apis/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.apis 
  ALTER COLUMN created_at DROP DEFAULT;