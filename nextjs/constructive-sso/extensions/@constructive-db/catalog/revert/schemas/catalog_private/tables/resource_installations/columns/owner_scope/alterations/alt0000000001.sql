-- Revert: schemas/catalog_private/tables/resource_installations/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN owner_scope DROP NOT NULL;