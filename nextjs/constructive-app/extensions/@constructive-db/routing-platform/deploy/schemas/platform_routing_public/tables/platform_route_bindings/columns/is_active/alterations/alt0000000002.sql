-- Deploy: schemas/platform_routing_public/tables/platform_route_bindings/columns/is_active/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/table
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/columns/is_active/column


ALTER TABLE platform_routing_public.platform_route_bindings 
  ALTER COLUMN is_active SET DEFAULT true;