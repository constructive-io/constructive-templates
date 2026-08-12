-- Revert: schemas/catalog_public/tables/resource_definitions/columns/kind/column


ALTER TABLE catalog_public.resource_definitions 
  DROP COLUMN kind RESTRICT;