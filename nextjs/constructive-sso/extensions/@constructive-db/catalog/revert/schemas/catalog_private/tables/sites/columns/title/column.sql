-- Revert: schemas/catalog_private/tables/sites/columns/title/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN title RESTRICT;