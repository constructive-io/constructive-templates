-- Revert: schemas/catalog_public/tables/resource_definitions/columns/namespace_id/alterations/alt0000000001


ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN namespace_id DROP NOT NULL;