-- Deploy: schemas/routing_public/tables/route_bindings/columns/is_active/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/columns/is_active/column


COMMENT ON COLUMN routing_public.route_bindings.is_active IS 'Active flag compiled from the source route';