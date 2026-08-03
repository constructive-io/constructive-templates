-- Revert: schemas/catalog_public/tables/apis/columns/updated_at/column


ALTER TABLE catalog_public.apis 
  DROP COLUMN updated_at RESTRICT;