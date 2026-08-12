-- Revert: schemas/catalog_private/tables/resource_definitions/columns/namespace_id/alterations/alt0000000001


ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN namespace_id DROP NOT NULL;