-- Deploy: schemas/platform_routing_public/tables/platform_route_bindings/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/table
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/columns/updated_at/column


ALTER TABLE platform_routing_public.platform_route_bindings 
  ALTER COLUMN updated_at SET NOT NULL;