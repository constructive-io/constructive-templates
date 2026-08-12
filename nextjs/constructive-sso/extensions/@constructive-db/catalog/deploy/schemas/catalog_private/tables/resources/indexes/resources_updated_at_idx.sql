-- Deploy: schemas/catalog_private/tables/resources/indexes/resources_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/table
-- requires: schemas/catalog_private/tables/resources/columns/updated_at/column


CREATE INDEX resources_updated_at_idx ON catalog_private.resources (updated_at);