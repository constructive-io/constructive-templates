-- Deploy: schemas/routing_public/tables/routes/constraints/routes_target_bucket_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/catalog_private/schema
-- requires: schemas/routing_public/tables/routes/table
-- requires: schemas/catalog_private/tables/buckets/table


ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_target_bucket_id_fkey
    FOREIGN KEY(target_bucket_id)
    REFERENCES catalog_private.buckets (id)
    ON DELETE CASCADE;