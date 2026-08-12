-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/path/alterations/alt0000000005
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/path/column


COMMENT ON COLUMN platform_routing_public.platform_routes.path IS '@has_guard
Path prefix this route matches; must begin with / and carry no trailing slash';