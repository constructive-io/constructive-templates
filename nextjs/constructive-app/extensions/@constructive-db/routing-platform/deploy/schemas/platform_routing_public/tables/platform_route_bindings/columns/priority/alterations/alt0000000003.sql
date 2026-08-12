-- Deploy: schemas/platform_routing_public/tables/platform_route_bindings/columns/priority/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/columns/priority/column


COMMENT ON COLUMN platform_routing_public.platform_route_bindings.priority IS 'Priority compiled from the source route';