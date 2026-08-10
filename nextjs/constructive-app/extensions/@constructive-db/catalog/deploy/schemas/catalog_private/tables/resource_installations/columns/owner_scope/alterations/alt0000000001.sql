-- Deploy: schemas/catalog_private/tables/resource_installations/columns/owner_scope/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_installations/table
-- requires: schemas/catalog_private/tables/resource_installations/columns/owner_scope/column


ALTER TABLE catalog_private.resource_installations 
  ALTER COLUMN owner_scope SET NOT NULL;