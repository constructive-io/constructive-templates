-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/target_site_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/target_site_id/column


COMMENT ON COLUMN platform_routing_public.platform_routes.target_site_id IS '@has_guard
Site catalog row this route targets; must be owner-matched or visible cross-scope';