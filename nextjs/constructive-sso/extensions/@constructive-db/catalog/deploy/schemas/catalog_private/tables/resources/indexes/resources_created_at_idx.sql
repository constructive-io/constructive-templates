-- Deploy: schemas/catalog_private/tables/resources/indexes/resources_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/table
-- requires: schemas/catalog_private/tables/resources/columns/created_at/column


CREATE INDEX resources_created_at_idx ON catalog_private.resources (created_at);