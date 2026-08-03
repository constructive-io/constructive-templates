-- Revert: schemas/catalog_public/tables/apps/columns/database_id/column


ALTER TABLE catalog_public.apps 
  DROP COLUMN database_id RESTRICT;