-- Deploy: schemas/routing_public/tables/platform_sites/columns/bucket_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/table
-- requires: schemas/routing_public/tables/platform_sites/columns/bucket_id/column
-- requires: schemas/routing_public/tables/platform_sites/columns/resource_id/column
-- requires: schemas/routing_public/tables/platform_sites/columns/installation_id/column


ALTER TABLE routing_public.platform_sites 
  ADD CONSTRAINT platform_sites_bucket_id_resource_id_installation_id_chk 
    CHECK (num_nonnulls(bucket_id, resource_id, installation_id) = 1);