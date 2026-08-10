-- Revert: schemas/catalog_private/tables/domains/columns/created_at/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN created_at RESTRICT;