-- Revert: schemas/catalog_public/tables/apps/columns/updated_at/column


ALTER TABLE catalog_public.apps 
  DROP COLUMN updated_at RESTRICT;