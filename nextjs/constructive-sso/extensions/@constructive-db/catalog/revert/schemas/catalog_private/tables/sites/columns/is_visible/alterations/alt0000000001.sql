-- Revert: schemas/catalog_private/tables/sites/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_private.sites 
  ALTER COLUMN is_visible DROP NOT NULL;