-- Revert: schemas/catalog_public/tables/resources/columns/namespace_id/column


ALTER TABLE catalog_public.resources 
  DROP COLUMN namespace_id RESTRICT;