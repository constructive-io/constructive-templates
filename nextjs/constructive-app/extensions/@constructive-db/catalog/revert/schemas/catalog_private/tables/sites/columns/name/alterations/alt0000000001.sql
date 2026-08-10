-- Revert: schemas/catalog_private/tables/sites/columns/name/alterations/alt0000000001


ALTER TABLE catalog_private.sites 
  ALTER COLUMN name DROP NOT NULL;