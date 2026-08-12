-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/domain_id/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/domain_id/column


COMMENT ON COLUMN platform_routing_public.platform_routes.domain_id IS '@has_guard
Domain whose hostname this route serves';