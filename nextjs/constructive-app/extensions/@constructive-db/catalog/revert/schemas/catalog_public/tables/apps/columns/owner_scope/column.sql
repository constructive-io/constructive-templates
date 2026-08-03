-- Revert: schemas/catalog_public/tables/apps/columns/owner_scope/column


ALTER TABLE catalog_public.apps 
  DROP COLUMN owner_scope RESTRICT;