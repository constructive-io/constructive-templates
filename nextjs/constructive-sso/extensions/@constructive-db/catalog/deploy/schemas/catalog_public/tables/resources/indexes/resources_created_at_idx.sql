-- Deploy: schemas/catalog_public/tables/resources/indexes/resources_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table
-- requires: schemas/catalog_public/tables/resources/columns/created_at/column


CREATE INDEX resources_created_at_idx ON catalog_public.resources (created_at);