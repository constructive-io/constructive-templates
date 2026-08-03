-- Revert: schemas/platform_routing_public/tables/platform_route_bindings/columns/target_bucket_id/column


ALTER TABLE platform_routing_public.platform_route_bindings 
  DROP COLUMN target_bucket_id RESTRICT;