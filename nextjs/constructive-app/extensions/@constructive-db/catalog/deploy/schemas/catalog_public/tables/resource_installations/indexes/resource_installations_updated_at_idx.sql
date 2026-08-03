-- Deploy: schemas/catalog_public/tables/resource_installations/indexes/resource_installations_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_installations/table
-- requires: schemas/catalog_public/tables/resource_installations/columns/updated_at/column


CREATE INDEX resource_installations_updated_at_idx ON catalog_public.resource_installations (updated_at);