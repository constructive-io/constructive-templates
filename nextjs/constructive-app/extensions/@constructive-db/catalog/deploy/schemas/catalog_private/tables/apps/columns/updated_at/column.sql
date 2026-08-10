-- Deploy: schemas/catalog_private/tables/apps/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table


ALTER TABLE catalog_private.apps 
  ADD COLUMN updated_at timestamptz;