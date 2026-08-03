-- Revert: schemas/platform_routing_public/tables/platform_route_bindings/columns/is_active/alterations/alt0000000002


ALTER TABLE platform_routing_public.platform_route_bindings 
  ALTER COLUMN is_active DROP DEFAULT;