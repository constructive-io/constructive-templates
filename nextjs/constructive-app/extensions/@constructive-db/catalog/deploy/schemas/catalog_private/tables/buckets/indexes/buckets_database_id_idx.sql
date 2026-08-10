-- Deploy: schemas/catalog_private/tables/buckets/indexes/buckets_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table
-- requires: schemas/catalog_private/tables/buckets/columns/database_id/column


CREATE INDEX buckets_database_id_idx ON catalog_private.buckets (database_id);