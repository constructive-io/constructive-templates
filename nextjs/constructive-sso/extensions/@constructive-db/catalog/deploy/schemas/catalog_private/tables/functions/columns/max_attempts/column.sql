-- Deploy: schemas/catalog_private/tables/functions/columns/max_attempts/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table


ALTER TABLE catalog_private.functions 
  ADD COLUMN max_attempts int;