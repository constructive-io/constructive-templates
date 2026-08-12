-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/target_api_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/table
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/target_api_id/column
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/target_site_id/column
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/target_bucket_id/column
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/target_service_id/column
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/target_function_id/column


ALTER TABLE platform_routing_public.platform_routes 
  ADD CONSTRAINT platform_routes_target_api_id_target_site_id_target_function_id 
    CHECK (num_nonnulls(target_api_id, target_site_id, target_function_id, target_service_id, target_bucket_id) = 1);