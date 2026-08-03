-- Revert: schemas/catalog_public/tables/domains/columns/managed/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN managed RESTRICT;