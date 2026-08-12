-- Revert: schemas/catalog_private/tables/namespaces/columns/database_id/column


ALTER TABLE catalog_private.namespaces 
  DROP COLUMN database_id RESTRICT;