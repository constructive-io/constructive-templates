-- Deploy: schemas/catalog_public/tables/resource_installations/indexes/resource_installations_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_installations/table
-- requires: schemas/catalog_public/tables/resource_installations/columns/created_at/column


CREATE INDEX resource_installations_created_at_idx ON catalog_public.resource_installations (created_at);