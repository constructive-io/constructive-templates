-- Revert: schemas/catalog_private/tables/domains/columns/id/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN id RESTRICT;