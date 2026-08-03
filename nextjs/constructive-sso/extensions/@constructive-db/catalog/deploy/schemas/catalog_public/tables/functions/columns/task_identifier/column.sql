-- Deploy: schemas/catalog_public/tables/functions/columns/task_identifier/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/functions/table


ALTER TABLE catalog_public.functions 
  ADD COLUMN task_identifier text;