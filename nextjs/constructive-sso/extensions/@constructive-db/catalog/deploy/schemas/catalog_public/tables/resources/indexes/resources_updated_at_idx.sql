-- Deploy: schemas/catalog_public/tables/resources/indexes/resources_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table
-- requires: schemas/catalog_public/tables/resources/columns/updated_at/column


CREATE INDEX resources_updated_at_idx ON catalog_public.resources (updated_at);