-- Revert: schemas/catalog_private/tables/namespaces/columns/updated_at/column


ALTER TABLE catalog_private.namespaces 
  DROP COLUMN updated_at RESTRICT;