-- Revert: schemas/catalog_public/tables/domains/columns/owner_scope/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN owner_scope RESTRICT;