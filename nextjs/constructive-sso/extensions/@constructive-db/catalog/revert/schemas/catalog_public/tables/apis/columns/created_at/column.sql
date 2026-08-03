-- Revert: schemas/catalog_public/tables/apis/columns/created_at/column


ALTER TABLE catalog_public.apis 
  DROP COLUMN created_at RESTRICT;