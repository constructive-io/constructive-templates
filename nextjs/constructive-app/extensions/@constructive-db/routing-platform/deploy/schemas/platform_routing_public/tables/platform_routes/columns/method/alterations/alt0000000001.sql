-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/method/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/method/column


COMMENT ON COLUMN platform_routing_public.platform_routes.method IS 'Uppercase HTTP method this route matches; NULL matches any method';