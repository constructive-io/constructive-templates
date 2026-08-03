-- Deploy: schemas/catalog_public/tables/apis/indexes/apis_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table
-- requires: schemas/catalog_public/tables/apis/columns/created_at/column


CREATE INDEX apis_created_at_idx ON catalog_public.apis (created_at);