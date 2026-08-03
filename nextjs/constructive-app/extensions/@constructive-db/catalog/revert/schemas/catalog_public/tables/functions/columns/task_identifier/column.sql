-- Revert: schemas/catalog_public/tables/functions/columns/task_identifier/column


ALTER TABLE catalog_public.functions 
  DROP COLUMN task_identifier RESTRICT;