-- Revert: schemas/platform_routing_public/tables/platform_route_bindings/constraints/platform_route_bindings_pkey/constraint


ALTER TABLE platform_routing_public.platform_route_bindings 
  DROP CONSTRAINT platform_route_bindings_pkey RESTRICT;