-- Revert: schemas/catalog_private/tables/functions/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_private.functions 
  ALTER COLUMN updated_at DROP DEFAULT;