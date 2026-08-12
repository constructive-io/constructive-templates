-- Revert: schemas/catalog_private/tables/resource_definitions/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN created_at DROP DEFAULT;