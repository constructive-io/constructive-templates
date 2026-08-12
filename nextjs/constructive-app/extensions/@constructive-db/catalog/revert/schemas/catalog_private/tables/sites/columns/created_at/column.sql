-- Revert: schemas/catalog_private/tables/sites/columns/created_at/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN created_at RESTRICT;