-- Deploy: schemas/catalog_public/tables/resource_definitions/indexes/resource_definitions_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_definitions/table
-- requires: schemas/catalog_public/tables/resource_definitions/columns/updated_at/column


CREATE INDEX resource_definitions_updated_at_idx ON catalog_public.resource_definitions (updated_at);