-- Revert: schemas/catalog_private/tables/sites/columns/updated_at/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN updated_at RESTRICT;