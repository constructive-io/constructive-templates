-- Deploy: schemas/routing_public/tables/sites/constraints/sites_bucket_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/routing_public/tables/sites/table
-- requires: schemas/catalog_private/tables/buckets/table


ALTER TABLE routing_public.sites 
  ADD CONSTRAINT sites_bucket_id_fkey
    FOREIGN KEY(bucket_id)
    REFERENCES catalog_private.buckets (id)
    ON DELETE CASCADE;