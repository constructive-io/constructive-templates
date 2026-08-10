-- Deploy: schemas/catalog_private/tables/apis/indexes/apis_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/table
-- requires: schemas/catalog_private/tables/apis/columns/updated_at/column


CREATE INDEX apis_updated_at_idx ON catalog_private.apis (updated_at);