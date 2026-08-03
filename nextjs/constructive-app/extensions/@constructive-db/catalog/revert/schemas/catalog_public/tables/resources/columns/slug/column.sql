-- Revert: schemas/catalog_public/tables/resources/columns/slug/column


ALTER TABLE catalog_public.resources 
  DROP COLUMN slug RESTRICT;