-- Deploy: schemas/platform_routing_public/tables/platform_route_bindings/indexes/platform_route_bindings_domain_id_is_active_idx
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/table
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/columns/domain_id/column
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/columns/is_active/column


CREATE INDEX platform_route_bindings_domain_id_is_active_idx ON platform_routing_public.platform_route_bindings (domain_id, is_active);