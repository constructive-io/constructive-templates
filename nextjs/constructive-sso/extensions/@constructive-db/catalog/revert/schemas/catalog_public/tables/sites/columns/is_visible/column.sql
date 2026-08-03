-- Revert: schemas/catalog_public/tables/sites/columns/is_visible/column


ALTER TABLE catalog_public.sites 
  DROP COLUMN is_visible RESTRICT;