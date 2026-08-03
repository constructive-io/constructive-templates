-- Revert: schemas/catalog_public/tables/sites/columns/name/column


ALTER TABLE catalog_public.sites 
  DROP COLUMN name RESTRICT;