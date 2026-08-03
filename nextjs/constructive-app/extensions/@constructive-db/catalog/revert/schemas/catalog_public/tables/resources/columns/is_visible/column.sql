-- Revert: schemas/catalog_public/tables/resources/columns/is_visible/column


ALTER TABLE catalog_public.resources 
  DROP COLUMN is_visible RESTRICT;