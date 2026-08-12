-- Deploy: schemas/catalog_private/tables/functions/columns/task_identifier/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table
-- requires: schemas/catalog_private/tables/functions/columns/task_identifier/column


ALTER TABLE catalog_private.functions 
  ALTER COLUMN task_identifier SET NOT NULL;