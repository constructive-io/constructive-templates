-- Revert: schemas/catalog_public/tables/domains/columns/updated_at/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN updated_at RESTRICT;