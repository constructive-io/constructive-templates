-- Revert: schemas/catalog_private/tables/functions/columns/task_identifier/alterations/alt0000000001


ALTER TABLE catalog_private.functions 
  ALTER COLUMN task_identifier DROP NOT NULL;