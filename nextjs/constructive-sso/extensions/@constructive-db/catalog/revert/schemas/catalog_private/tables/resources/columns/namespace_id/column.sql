-- Revert: schemas/catalog_private/tables/resources/columns/namespace_id/column


ALTER TABLE catalog_private.resources 
  DROP COLUMN namespace_id RESTRICT;