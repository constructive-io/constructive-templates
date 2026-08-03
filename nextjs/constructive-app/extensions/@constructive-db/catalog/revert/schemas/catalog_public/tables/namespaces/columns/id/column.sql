-- Revert: schemas/catalog_public/tables/namespaces/columns/id/column


ALTER TABLE catalog_public.namespaces 
  DROP COLUMN id RESTRICT;