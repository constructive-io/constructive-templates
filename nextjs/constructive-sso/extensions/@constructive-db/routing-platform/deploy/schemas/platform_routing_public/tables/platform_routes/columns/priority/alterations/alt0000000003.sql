-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/priority/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/priority/column


COMMENT ON COLUMN platform_routing_public.platform_routes.priority IS 'Higher priority wins between otherwise-equal matches';