-- Deploy: schemas/catalog_private/tables/apps/columns/is_visible/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table
-- requires: schemas/catalog_private/tables/apps/columns/is_visible/column


ALTER TABLE catalog_private.apps 
  ALTER COLUMN is_visible SET DEFAULT false;