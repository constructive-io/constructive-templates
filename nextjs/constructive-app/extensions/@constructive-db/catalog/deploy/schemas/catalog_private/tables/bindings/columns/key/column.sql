-- Deploy: schemas/catalog_private/tables/bindings/columns/key/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/table


ALTER TABLE catalog_private.bindings 
  ADD COLUMN key text;