-- Deploy: schemas/routing_public/tables/route_bindings/columns/target_service_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/columns/target_service_id/column


COMMENT ON COLUMN routing_public.route_bindings.target_service_id IS 'Resource catalog row (a Service resource) the source route targets';