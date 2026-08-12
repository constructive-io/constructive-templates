-- Revert: schemas/catalog_private/tables/resource_installations/columns/id/alterations/alt0000000002


ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN id DROP DEFAULT;