-- Revert: schemas/catalog_public/tables/apis/columns/database_id/column


ALTER TABLE catalog_public.apis 
  DROP COLUMN database_id RESTRICT;