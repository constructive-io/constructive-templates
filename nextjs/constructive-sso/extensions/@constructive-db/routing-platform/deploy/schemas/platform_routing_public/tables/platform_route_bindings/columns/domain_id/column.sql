-- Deploy: schemas/platform_routing_public/tables/platform_route_bindings/columns/domain_id/column
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/table


ALTER TABLE platform_routing_public.platform_route_bindings 
  ADD COLUMN domain_id uuid;