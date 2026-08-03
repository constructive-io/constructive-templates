-- Revert: schemas/catalog_public/tables/functions/columns/id/column


ALTER TABLE catalog_public.functions 
  DROP COLUMN id RESTRICT;