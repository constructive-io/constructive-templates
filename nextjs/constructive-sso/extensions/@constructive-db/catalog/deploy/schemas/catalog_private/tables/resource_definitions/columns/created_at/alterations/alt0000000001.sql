-- Deploy: schemas/catalog_private/tables/resource_definitions/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_definitions/table
-- requires: schemas/catalog_private/tables/resource_definitions/columns/created_at/column


ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN created_at SET DEFAULT now();