-- Revert: schemas/catalog_public/tables/domains/columns/created_at/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN created_at RESTRICT;