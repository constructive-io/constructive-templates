-- Deploy: schemas/catalog_private/tables/apis/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/table


ALTER TABLE catalog_private.apis 
  ADD COLUMN updated_at timestamptz;