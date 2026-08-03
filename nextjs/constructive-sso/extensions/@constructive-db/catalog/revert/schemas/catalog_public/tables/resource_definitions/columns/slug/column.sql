-- Revert: schemas/catalog_public/tables/resource_definitions/columns/slug/column


ALTER TABLE catalog_public.resource_definitions 
  DROP COLUMN slug RESTRICT;