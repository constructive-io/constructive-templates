-- Revert: schemas/catalog_public/tables/resources/columns/id/column


ALTER TABLE catalog_public.resources 
  DROP COLUMN id RESTRICT;