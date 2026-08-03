-- Deploy: schemas/catalog_public/tables/buckets/columns/key/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/buckets/columns/key/column


COMMENT ON COLUMN catalog_public.buckets.key IS 'Owner-local logical bucket key propagated from the source row';