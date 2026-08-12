-- Revert: schemas/catalog_private/tables/domains/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_private.domains 
  ALTER COLUMN is_visible DROP NOT NULL;