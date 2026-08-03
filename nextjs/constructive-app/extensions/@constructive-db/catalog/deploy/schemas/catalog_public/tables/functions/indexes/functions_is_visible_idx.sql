-- Deploy: schemas/catalog_public/tables/functions/indexes/functions_is_visible_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/functions/table
-- requires: schemas/catalog_public/tables/functions/columns/is_visible/column


CREATE INDEX functions_is_visible_idx ON catalog_public.functions (is_visible);