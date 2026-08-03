-- Revert: schemas/catalog_public/tables/domains/columns/id/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN id RESTRICT;