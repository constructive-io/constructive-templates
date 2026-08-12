-- Revert: schemas/catalog_private/tables/apps/columns/name/alterations/alt0000000001


ALTER TABLE catalog_private.apps 
  ALTER COLUMN name DROP NOT NULL;