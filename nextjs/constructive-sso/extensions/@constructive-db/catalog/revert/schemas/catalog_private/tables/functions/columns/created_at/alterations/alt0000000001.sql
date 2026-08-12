-- Revert: schemas/catalog_private/tables/functions/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.functions 
  ALTER COLUMN created_at DROP DEFAULT;