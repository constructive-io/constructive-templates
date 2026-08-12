-- Deploy: schemas/catalog_private/tables/functions/columns/queue_name/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table


ALTER TABLE catalog_private.functions 
  ADD COLUMN queue_name text;