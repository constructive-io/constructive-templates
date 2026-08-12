-- Deploy: schemas/catalog_private/tables/resources/columns/kind/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/table


ALTER TABLE catalog_private.resources 
  ADD COLUMN kind text;