-- Revert: schemas/catalog_public/tables/namespaces/columns/updated_at/column


ALTER TABLE catalog_public.namespaces 
  DROP COLUMN updated_at RESTRICT;