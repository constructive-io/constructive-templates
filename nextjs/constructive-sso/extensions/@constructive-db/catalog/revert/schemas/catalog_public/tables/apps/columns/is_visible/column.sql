-- Revert: schemas/catalog_public/tables/apps/columns/is_visible/column


ALTER TABLE catalog_public.apps 
  DROP COLUMN is_visible RESTRICT;