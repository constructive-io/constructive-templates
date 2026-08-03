-- Deploy: schemas/routing_public/tables/route_bindings/columns/priority/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/columns/priority/column


COMMENT ON COLUMN routing_public.route_bindings.priority IS 'Priority compiled from the source route';