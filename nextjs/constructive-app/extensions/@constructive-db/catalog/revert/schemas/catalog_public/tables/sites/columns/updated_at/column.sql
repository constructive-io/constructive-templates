-- Revert: schemas/catalog_public/tables/sites/columns/updated_at/column


ALTER TABLE catalog_public.sites 
  DROP COLUMN updated_at RESTRICT;