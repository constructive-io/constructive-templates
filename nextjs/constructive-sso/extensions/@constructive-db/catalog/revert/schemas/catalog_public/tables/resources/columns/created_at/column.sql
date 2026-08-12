-- Revert: schemas/catalog_public/tables/resources/columns/created_at/column


ALTER TABLE catalog_public.resources 
  DROP COLUMN created_at RESTRICT;