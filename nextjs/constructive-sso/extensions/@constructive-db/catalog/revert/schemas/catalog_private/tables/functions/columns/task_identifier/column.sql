-- Revert: schemas/catalog_private/tables/functions/columns/task_identifier/column


ALTER TABLE catalog_private.functions 
  DROP COLUMN task_identifier RESTRICT;