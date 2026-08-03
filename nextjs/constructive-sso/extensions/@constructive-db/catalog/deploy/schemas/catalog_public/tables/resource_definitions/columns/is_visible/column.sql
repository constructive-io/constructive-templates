-- Deploy: schemas/catalog_public/tables/resource_definitions/columns/is_visible/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_definitions/table


ALTER TABLE catalog_public.resource_definitions 
  ADD COLUMN is_visible boolean;