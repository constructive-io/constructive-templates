-- Revert: schemas/catalog_private/tables/domains/columns/updated_at/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN updated_at RESTRICT;