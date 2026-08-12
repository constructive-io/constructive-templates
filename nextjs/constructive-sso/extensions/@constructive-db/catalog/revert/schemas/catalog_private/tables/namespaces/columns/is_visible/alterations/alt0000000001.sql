-- Revert: schemas/catalog_private/tables/namespaces/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN is_visible DROP NOT NULL;