-- Revert: schemas/platform_routing_public/tables/platform_route_bindings/columns/id/column


ALTER TABLE platform_routing_public.platform_route_bindings 
  DROP COLUMN id RESTRICT;