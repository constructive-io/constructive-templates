-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/is_active/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/is_active/column


COMMENT ON COLUMN platform_routing_public.platform_routes.is_active IS 'Inactive routes are excluded from resolution';