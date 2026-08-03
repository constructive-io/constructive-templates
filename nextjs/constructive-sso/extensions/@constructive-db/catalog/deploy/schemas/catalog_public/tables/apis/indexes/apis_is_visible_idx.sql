-- Deploy: schemas/catalog_public/tables/apis/indexes/apis_is_visible_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table
-- requires: schemas/catalog_public/tables/apis/columns/is_visible/column


CREATE INDEX apis_is_visible_idx ON catalog_public.apis (is_visible);