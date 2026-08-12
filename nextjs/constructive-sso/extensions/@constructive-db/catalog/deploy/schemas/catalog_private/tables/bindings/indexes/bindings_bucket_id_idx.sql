-- Deploy: schemas/catalog_private/tables/bindings/indexes/bindings_bucket_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/table
-- requires: schemas/catalog_private/tables/bindings/columns/bucket_id/column


CREATE INDEX bindings_bucket_id_idx ON catalog_private.bindings (bucket_id);