-- Revert: schemas/catalog_public/tables/apps/columns/name/column


ALTER TABLE catalog_public.apps 
  DROP COLUMN name RESTRICT;