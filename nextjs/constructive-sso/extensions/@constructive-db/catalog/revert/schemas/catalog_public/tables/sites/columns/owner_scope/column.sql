-- Revert: schemas/catalog_public/tables/sites/columns/owner_scope/column


ALTER TABLE catalog_public.sites 
  DROP COLUMN owner_scope RESTRICT;