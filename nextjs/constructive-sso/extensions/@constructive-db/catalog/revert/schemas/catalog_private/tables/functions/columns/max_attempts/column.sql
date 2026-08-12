-- Revert: schemas/catalog_private/tables/functions/columns/max_attempts/column


ALTER TABLE catalog_private.functions 
  DROP COLUMN max_attempts RESTRICT;