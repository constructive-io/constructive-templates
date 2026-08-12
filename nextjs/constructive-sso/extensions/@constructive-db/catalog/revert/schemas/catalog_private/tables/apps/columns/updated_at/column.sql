-- Revert: schemas/catalog_private/tables/apps/columns/updated_at/column


ALTER TABLE catalog_private.apps 
  DROP COLUMN updated_at RESTRICT;