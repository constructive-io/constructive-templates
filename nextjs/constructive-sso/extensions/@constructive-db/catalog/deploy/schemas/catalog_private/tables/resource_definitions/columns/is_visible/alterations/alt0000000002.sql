-- Deploy: schemas/catalog_private/tables/resource_definitions/columns/is_visible/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_definitions/table
-- requires: schemas/catalog_private/tables/resource_definitions/columns/is_visible/column


ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN is_visible SET DEFAULT false;