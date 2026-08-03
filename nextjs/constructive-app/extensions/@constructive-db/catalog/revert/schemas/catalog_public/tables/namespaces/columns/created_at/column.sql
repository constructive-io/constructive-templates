-- Revert: schemas/catalog_public/tables/namespaces/columns/created_at/column


ALTER TABLE catalog_public.namespaces 
  DROP COLUMN created_at RESTRICT;