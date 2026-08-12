-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/domain_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/domain_id/column


COMMENT ON COLUMN platform_routing_public.platform_routes.domain_id IS 'Domain whose hostname this route serves';