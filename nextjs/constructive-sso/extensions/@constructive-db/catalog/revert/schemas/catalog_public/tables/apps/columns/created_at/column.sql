-- Revert: schemas/catalog_public/tables/apps/columns/created_at/column


ALTER TABLE catalog_public.apps 
  DROP COLUMN created_at RESTRICT;