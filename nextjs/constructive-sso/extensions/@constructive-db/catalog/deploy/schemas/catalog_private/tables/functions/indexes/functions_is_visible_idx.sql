-- Deploy: schemas/catalog_private/tables/functions/indexes/functions_is_visible_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table
-- requires: schemas/catalog_private/tables/functions/columns/is_visible/column


CREATE INDEX functions_is_visible_idx ON catalog_private.functions (is_visible);