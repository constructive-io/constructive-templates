-- Revert: schemas/catalog_private/tables/resource_installations/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN created_at DROP DEFAULT;