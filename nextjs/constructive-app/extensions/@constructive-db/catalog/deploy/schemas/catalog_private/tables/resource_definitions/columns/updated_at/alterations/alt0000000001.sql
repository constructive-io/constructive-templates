-- Deploy: schemas/catalog_private/tables/resource_definitions/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_definitions/table
-- requires: schemas/catalog_private/tables/resource_definitions/columns/updated_at/column


ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN updated_at SET DEFAULT now();