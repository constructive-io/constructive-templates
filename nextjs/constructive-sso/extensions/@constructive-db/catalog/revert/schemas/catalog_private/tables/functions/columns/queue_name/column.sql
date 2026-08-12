-- Revert: schemas/catalog_private/tables/functions/columns/queue_name/column


ALTER TABLE catalog_private.functions 
  DROP COLUMN queue_name RESTRICT;