-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/target_service_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/target_service_id/column


COMMENT ON COLUMN platform_routing_public.platform_routes.target_service_id IS 'Resource catalog row (a Service resource) this route targets; must be owner-matched or visible cross-scope';