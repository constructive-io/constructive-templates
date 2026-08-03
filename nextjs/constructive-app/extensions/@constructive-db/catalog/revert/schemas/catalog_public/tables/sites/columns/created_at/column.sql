-- Revert: schemas/catalog_public/tables/sites/columns/created_at/column


ALTER TABLE catalog_public.sites 
  DROP COLUMN created_at RESTRICT;