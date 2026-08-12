-- Deploy: schemas/routing_public/tables/routes/constraints/routes_target_bucket_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table
-- requires: schemas/catalog_public/tables/buckets/table


ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_target_bucket_id_fkey
    FOREIGN KEY(target_bucket_id)
    REFERENCES catalog_public.buckets (id)
    ON DELETE CASCADE;