-- Deploy: schemas/catalog_private/tables/functions/indexes/functions_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table
-- requires: schemas/catalog_private/tables/functions/columns/created_at/column


CREATE INDEX functions_created_at_idx ON catalog_private.functions (created_at);