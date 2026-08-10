-- Deploy: schemas/catalog_private/tables/apis/columns/is_visible/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/table


ALTER TABLE catalog_private.apis 
  ADD COLUMN is_visible boolean;