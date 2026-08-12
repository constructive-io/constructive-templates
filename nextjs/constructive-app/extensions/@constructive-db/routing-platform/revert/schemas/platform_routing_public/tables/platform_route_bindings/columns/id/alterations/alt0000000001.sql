-- Revert: schemas/platform_routing_public/tables/platform_route_bindings/columns/id/alterations/alt0000000001


ALTER TABLE platform_routing_public.platform_route_bindings 
  ALTER COLUMN id DROP NOT NULL;