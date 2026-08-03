-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/config/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/config/column


COMMENT ON COLUMN platform_routing_public.platform_routes.config IS 'Route metadata; target configuration is read live from the typed catalog, never copied here';