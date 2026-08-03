-- Revert: schemas/catalog_public/tables/domains/columns/is_visible/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN is_visible RESTRICT;