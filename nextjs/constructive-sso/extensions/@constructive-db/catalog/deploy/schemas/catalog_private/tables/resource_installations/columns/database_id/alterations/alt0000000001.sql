-- Deploy: schemas/catalog_private/tables/resource_installations/columns/database_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_installations/table
-- requires: schemas/catalog_private/tables/resource_installations/columns/database_id/column


ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN database_id SET NOT NULL;