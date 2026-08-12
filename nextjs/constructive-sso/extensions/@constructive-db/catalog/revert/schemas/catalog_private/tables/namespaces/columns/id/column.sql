-- Revert: schemas/catalog_private/tables/namespaces/columns/id/column


ALTER TABLE catalog_private.namespaces 
  DROP COLUMN id RESTRICT;