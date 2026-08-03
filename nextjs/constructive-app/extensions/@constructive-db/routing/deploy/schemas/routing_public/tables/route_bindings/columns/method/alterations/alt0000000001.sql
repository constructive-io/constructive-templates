-- Deploy: schemas/routing_public/tables/route_bindings/columns/method/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/columns/method/column


COMMENT ON COLUMN routing_public.route_bindings.method IS 'HTTP method this binding matches; NULL matches any method';