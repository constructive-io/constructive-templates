-- Revert: schemas/catalog_public/tables/sites/columns/title/column


ALTER TABLE catalog_public.sites 
  DROP COLUMN title RESTRICT;