-- Deploy: schemas/platform_routing_public/tables/platform_route_bindings/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/table


COMMENT ON TABLE platform_routing_public.platform_route_bindings IS 'Compiled route precedence index maintained by route sync triggers; carries typed target ids only, read through the resolver';