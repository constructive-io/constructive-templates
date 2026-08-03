-- Revert: schemas/catalog_public/tables/functions/columns/updated_at/column


ALTER TABLE catalog_public.functions 
  DROP COLUMN updated_at RESTRICT;