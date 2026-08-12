-- Revert: schemas/catalog_private/tables/apps/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_private.apps 
  ALTER COLUMN is_visible DROP NOT NULL;