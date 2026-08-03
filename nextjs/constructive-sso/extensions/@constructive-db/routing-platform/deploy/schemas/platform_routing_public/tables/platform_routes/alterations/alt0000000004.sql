-- Deploy: schemas/platform_routing_public/tables/platform_routes/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/table


COMMENT ON TABLE platform_routing_public.platform_routes IS '@scope platform
@has_guard
@scopeTier global
Routes binding a domain hostname and path to a typed catalog target';