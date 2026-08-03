-- Revert: schemas/platform_routing_public/tables/platform_route_bindings/columns/target_site_id/column


ALTER TABLE platform_routing_public.platform_route_bindings 
  DROP COLUMN target_site_id RESTRICT;