-- Revert: schemas/catalog_private/tables/domains/columns/is_visible/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN is_visible RESTRICT;