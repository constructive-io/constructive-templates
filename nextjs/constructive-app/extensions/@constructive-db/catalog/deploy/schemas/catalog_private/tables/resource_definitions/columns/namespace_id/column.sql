-- Deploy: schemas/catalog_private/tables/resource_definitions/columns/namespace_id/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_definitions/table


ALTER TABLE catalog_private.resource_definitions 
  ADD COLUMN namespace_id uuid;