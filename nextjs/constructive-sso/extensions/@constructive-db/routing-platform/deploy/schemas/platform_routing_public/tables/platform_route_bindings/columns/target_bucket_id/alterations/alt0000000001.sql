-- Deploy: schemas/platform_routing_public/tables/platform_route_bindings/columns/target_bucket_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/columns/target_bucket_id/column


COMMENT ON COLUMN platform_routing_public.platform_route_bindings.target_bucket_id IS 'Bucket catalog row the source route targets';