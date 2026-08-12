-- Deploy: schemas/catalog_private/tables/resources/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/table


ALTER TABLE catalog_private.resources 
  ADD COLUMN updated_at timestamptz;