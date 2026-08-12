-- Deploy: schemas/catalog_private/tables/resource_installations/columns/id/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_installations/table


ALTER TABLE catalog_private.resource_installations 
  ADD COLUMN id uuid;