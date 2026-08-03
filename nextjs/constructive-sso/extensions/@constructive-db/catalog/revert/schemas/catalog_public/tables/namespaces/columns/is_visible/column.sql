-- Revert: schemas/catalog_public/tables/namespaces/columns/is_visible/column


ALTER TABLE catalog_public.namespaces 
  DROP COLUMN is_visible RESTRICT;