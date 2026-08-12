-- Revert: schemas/catalog_private/tables/sites/columns/id/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN id RESTRICT;