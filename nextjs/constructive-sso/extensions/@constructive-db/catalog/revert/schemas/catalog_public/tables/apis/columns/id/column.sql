-- Revert: schemas/catalog_public/tables/apis/columns/id/column


ALTER TABLE catalog_public.apis 
  DROP COLUMN id RESTRICT;