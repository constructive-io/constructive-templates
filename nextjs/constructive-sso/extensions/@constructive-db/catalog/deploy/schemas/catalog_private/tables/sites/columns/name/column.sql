-- Deploy: schemas/catalog_private/tables/sites/columns/name/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/table


ALTER TABLE catalog_private.sites 
  ADD COLUMN name text;