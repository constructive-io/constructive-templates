-- Revert: schemas/catalog_public/tables/sites/columns/database_id/column


ALTER TABLE catalog_public.sites 
  DROP COLUMN database_id RESTRICT;