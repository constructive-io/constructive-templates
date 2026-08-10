-- Deploy: schemas/catalog_private/tables/apis/columns/owner_key/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/table


ALTER TABLE catalog_private.apis 
  ADD COLUMN owner_key uuid;