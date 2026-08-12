-- Revert: schemas/catalog_private/tables/resource_definitions/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN updated_at DROP DEFAULT;