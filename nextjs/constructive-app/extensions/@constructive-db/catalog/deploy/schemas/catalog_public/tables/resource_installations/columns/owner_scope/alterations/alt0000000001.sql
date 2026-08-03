-- Deploy: schemas/catalog_public/tables/resource_installations/columns/owner_scope/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_installations/table
-- requires: schemas/catalog_public/tables/resource_installations/columns/owner_scope/column


ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN owner_scope SET NOT NULL;