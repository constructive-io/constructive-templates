-- Revert: schemas/catalog_private/tables/resource_installations/columns/slug/alterations/alt0000000001


ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN slug DROP NOT NULL;