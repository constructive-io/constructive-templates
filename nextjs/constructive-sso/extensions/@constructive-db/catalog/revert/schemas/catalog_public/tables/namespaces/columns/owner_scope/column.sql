-- Revert: schemas/catalog_public/tables/namespaces/columns/owner_scope/column


ALTER TABLE catalog_public.namespaces 
  DROP COLUMN owner_scope RESTRICT;