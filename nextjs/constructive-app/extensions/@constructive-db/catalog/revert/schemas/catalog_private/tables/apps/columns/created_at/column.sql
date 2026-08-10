-- Revert: schemas/catalog_private/tables/apps/columns/created_at/column


ALTER TABLE catalog_private.apps 
  DROP COLUMN created_at RESTRICT;