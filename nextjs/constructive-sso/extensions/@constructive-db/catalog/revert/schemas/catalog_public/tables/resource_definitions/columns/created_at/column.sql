-- Revert: schemas/catalog_public/tables/resource_definitions/columns/created_at/column


ALTER TABLE catalog_public.resource_definitions 
  DROP COLUMN created_at RESTRICT;