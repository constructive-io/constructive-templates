-- Revert: schemas/platform_routing_public/tables/platform_route_bindings/columns/target_function_id/column


ALTER TABLE platform_routing_public.platform_route_bindings 
  DROP COLUMN target_function_id RESTRICT;