-- Deploy: schemas/routing_public/tables/platform_sites/constraints/platform_sites_bucket_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table
-- requires: schemas/routing_public/tables/platform_sites/table


ALTER TABLE routing_public.platform_sites 
  ADD CONSTRAINT platform_sites_bucket_id_fkey
    FOREIGN KEY(bucket_id)
    REFERENCES catalog_private.buckets (id)
    ON DELETE CASCADE;