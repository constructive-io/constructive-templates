-- Revert: schemas/catalog_private/tables/resource_installations/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN is_visible DROP NOT NULL;