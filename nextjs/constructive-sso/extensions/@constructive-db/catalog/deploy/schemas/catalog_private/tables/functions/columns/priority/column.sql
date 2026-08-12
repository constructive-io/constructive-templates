-- Deploy: schemas/catalog_private/tables/functions/columns/priority/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table


ALTER TABLE catalog_private.functions 
  ADD COLUMN priority int;