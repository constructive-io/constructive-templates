-- Revert: schemas/catalog_public/tables/domains/columns/database_id/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN database_id RESTRICT;