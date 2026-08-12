-- Revert: schemas/catalog_private/tables/domains/columns/database_id/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN database_id RESTRICT;