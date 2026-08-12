-- Revert: schemas/catalog_public/tables/namespaces/columns/database_id/column


ALTER TABLE catalog_public.namespaces 
  DROP COLUMN database_id RESTRICT;