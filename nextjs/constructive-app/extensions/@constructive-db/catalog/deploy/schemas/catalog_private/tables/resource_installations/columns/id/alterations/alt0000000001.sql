-- Deploy: schemas/catalog_private/tables/resource_installations/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_installations/table
-- requires: schemas/catalog_private/tables/resource_installations/columns/id/column


ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN id SET NOT NULL;