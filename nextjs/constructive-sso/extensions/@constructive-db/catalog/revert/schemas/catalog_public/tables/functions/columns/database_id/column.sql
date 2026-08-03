-- Revert: schemas/catalog_public/tables/functions/columns/database_id/column


ALTER TABLE catalog_public.functions 
  DROP COLUMN database_id RESTRICT;