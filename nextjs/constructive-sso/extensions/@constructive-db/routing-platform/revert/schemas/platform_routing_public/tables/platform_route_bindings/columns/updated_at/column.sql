-- Revert: schemas/platform_routing_public/tables/platform_route_bindings/columns/updated_at/column


ALTER TABLE platform_routing_public.platform_route_bindings 
  DROP COLUMN updated_at RESTRICT;