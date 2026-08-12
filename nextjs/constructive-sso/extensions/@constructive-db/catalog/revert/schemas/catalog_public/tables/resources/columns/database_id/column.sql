-- Revert: schemas/catalog_public/tables/resources/columns/database_id/column


ALTER TABLE catalog_public.resources 
  DROP COLUMN database_id RESTRICT;