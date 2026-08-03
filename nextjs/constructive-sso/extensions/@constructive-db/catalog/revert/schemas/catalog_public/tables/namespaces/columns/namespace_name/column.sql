-- Revert: schemas/catalog_public/tables/namespaces/columns/namespace_name/column


ALTER TABLE catalog_public.namespaces 
  DROP COLUMN namespace_name RESTRICT;