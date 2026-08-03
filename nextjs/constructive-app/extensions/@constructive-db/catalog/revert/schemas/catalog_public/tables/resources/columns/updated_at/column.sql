-- Revert: schemas/catalog_public/tables/resources/columns/updated_at/column


ALTER TABLE catalog_public.resources 
  DROP COLUMN updated_at RESTRICT;