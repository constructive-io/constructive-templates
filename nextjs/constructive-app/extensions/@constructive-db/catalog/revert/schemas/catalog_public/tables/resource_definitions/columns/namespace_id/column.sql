-- Revert: schemas/catalog_public/tables/resource_definitions/columns/namespace_id/column


ALTER TABLE catalog_public.resource_definitions 
  DROP COLUMN namespace_id RESTRICT;