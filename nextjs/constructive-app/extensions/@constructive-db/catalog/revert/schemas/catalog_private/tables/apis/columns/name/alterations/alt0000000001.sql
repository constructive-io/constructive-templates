-- Revert: schemas/catalog_private/tables/apis/columns/name/alterations/alt0000000001


ALTER TABLE catalog_private.apis 
  ALTER COLUMN name DROP NOT NULL;