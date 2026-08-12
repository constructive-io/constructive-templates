-- Revert: schemas/catalog_private/tables/resource_installations/columns/namespace_id/alterations/alt0000000001


ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN namespace_id DROP NOT NULL;