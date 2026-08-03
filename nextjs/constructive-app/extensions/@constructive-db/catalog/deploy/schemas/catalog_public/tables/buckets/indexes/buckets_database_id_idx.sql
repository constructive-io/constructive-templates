-- Deploy: schemas/catalog_public/tables/buckets/indexes/buckets_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/buckets/table
-- requires: schemas/catalog_public/tables/buckets/columns/database_id/column


CREATE INDEX buckets_database_id_idx ON catalog_public.buckets (database_id);