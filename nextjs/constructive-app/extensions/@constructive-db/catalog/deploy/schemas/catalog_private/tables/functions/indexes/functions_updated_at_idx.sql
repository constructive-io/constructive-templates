-- Deploy: schemas/catalog_private/tables/functions/indexes/functions_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table
-- requires: schemas/catalog_private/tables/functions/columns/updated_at/column


CREATE INDEX functions_updated_at_idx ON catalog_private.functions (updated_at);