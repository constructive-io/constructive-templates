-- Revert: schemas/catalog_public/tables/resource_definitions/columns/is_visible/column


ALTER TABLE catalog_public.resource_definitions 
  DROP COLUMN is_visible RESTRICT;