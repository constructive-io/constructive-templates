-- Deploy: schemas/platform_routing_public/tables/platform_route_bindings/columns/priority/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/table
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/columns/priority/column


ALTER TABLE platform_routing_public.platform_route_bindings 
  ALTER COLUMN priority SET DEFAULT 0;