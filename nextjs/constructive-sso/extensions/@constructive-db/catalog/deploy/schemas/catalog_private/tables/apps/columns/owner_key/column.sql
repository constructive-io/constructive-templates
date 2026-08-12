-- Deploy: schemas/catalog_private/tables/apps/columns/owner_key/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table


ALTER TABLE catalog_private.apps 
  ADD COLUMN owner_key uuid;