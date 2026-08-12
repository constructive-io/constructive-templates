-- Revert: schemas/catalog_private/tables/apps/columns/id/column


ALTER TABLE catalog_private.apps 
  DROP COLUMN id RESTRICT;