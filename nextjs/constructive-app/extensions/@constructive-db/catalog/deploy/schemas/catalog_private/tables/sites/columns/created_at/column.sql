-- Deploy: schemas/catalog_private/tables/sites/columns/created_at/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/table


ALTER TABLE catalog_private.sites 
  ADD COLUMN created_at timestamptz;