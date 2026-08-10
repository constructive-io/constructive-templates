-- Deploy: schemas/catalog_private/tables/functions/columns/task_identifier/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table


ALTER TABLE catalog_private.functions 
  ADD COLUMN task_identifier text;