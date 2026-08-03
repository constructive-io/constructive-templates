-- Deploy: schemas/catalog_public/tables/resource_definitions/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_definitions/table
-- requires: schemas/catalog_public/tables/resource_definitions/columns/updated_at/column


ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN updated_at SET DEFAULT now();