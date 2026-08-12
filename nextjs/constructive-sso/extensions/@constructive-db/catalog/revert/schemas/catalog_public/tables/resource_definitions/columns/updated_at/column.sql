-- Revert: schemas/catalog_public/tables/resource_definitions/columns/updated_at/column


ALTER TABLE catalog_public.resource_definitions 
  DROP COLUMN updated_at RESTRICT;