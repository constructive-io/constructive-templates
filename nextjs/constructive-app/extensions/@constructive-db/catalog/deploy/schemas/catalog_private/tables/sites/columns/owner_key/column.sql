-- Deploy: schemas/catalog_private/tables/sites/columns/owner_key/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/table


ALTER TABLE catalog_private.sites 
  ADD COLUMN owner_key uuid;