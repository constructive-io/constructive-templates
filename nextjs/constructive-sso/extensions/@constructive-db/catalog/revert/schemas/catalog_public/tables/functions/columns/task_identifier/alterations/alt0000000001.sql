-- Revert: schemas/catalog_public/tables/functions/columns/task_identifier/alterations/alt0000000001


ALTER TABLE catalog_public.functions 
  ALTER COLUMN task_identifier DROP NOT NULL;