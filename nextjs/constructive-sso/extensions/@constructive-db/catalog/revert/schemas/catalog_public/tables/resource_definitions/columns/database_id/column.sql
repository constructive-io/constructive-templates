-- Revert: schemas/catalog_public/tables/resource_definitions/columns/database_id/column


ALTER TABLE catalog_public.resource_definitions 
  DROP COLUMN database_id RESTRICT;