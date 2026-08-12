-- Revert: schemas/catalog_public/tables/sites/columns/id/column


ALTER TABLE catalog_public.sites 
  DROP COLUMN id RESTRICT;