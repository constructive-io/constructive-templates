-- Revert: schemas/catalog_private/tables/namespaces/columns/created_at/column


ALTER TABLE catalog_private.namespaces 
  DROP COLUMN created_at RESTRICT;