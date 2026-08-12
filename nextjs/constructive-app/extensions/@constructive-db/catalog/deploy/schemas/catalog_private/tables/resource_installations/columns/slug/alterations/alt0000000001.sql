-- Deploy: schemas/catalog_private/tables/resource_installations/columns/slug/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_installations/table
-- requires: schemas/catalog_private/tables/resource_installations/columns/slug/column


ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN slug SET NOT NULL;