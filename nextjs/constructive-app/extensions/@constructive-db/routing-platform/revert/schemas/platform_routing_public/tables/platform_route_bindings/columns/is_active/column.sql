-- Revert: schemas/platform_routing_public/tables/platform_route_bindings/columns/is_active/column


ALTER TABLE platform_routing_public.platform_route_bindings 
  DROP COLUMN is_active RESTRICT;