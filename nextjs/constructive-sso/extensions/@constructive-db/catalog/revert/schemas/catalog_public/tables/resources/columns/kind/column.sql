-- Revert: schemas/catalog_public/tables/resources/columns/kind/column


ALTER TABLE catalog_public.resources 
  DROP COLUMN kind RESTRICT;