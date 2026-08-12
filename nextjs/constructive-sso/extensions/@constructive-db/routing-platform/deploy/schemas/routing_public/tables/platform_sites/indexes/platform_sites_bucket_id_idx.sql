-- Deploy: schemas/routing_public/tables/platform_sites/indexes/platform_sites_bucket_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/table
-- requires: schemas/routing_public/tables/platform_sites/columns/bucket_id/column


CREATE INDEX platform_sites_bucket_id_idx ON routing_public.platform_sites (bucket_id);