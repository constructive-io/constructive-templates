-- Revert: schemas/catalog_public/tables/resource_definitions/columns/id/column


ALTER TABLE catalog_public.resource_definitions 
  DROP COLUMN id RESTRICT;