-- Deploy: schemas/catalog_private/tables/apis/indexes/apis_is_visible_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/table
-- requires: schemas/catalog_private/tables/apis/columns/is_visible/column


CREATE INDEX apis_is_visible_idx ON catalog_private.apis (is_visible);