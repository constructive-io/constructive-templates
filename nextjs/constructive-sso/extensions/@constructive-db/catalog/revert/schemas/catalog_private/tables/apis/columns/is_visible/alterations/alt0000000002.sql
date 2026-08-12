-- Revert: schemas/catalog_private/tables/apis/columns/is_visible/alterations/alt0000000002


ALTER TABLE catalog_private.apis 
  ALTER COLUMN is_visible DROP DEFAULT;