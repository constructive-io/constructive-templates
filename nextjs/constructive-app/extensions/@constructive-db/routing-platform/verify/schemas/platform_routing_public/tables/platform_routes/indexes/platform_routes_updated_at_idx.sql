-- Verify: schemas/platform_routing_public/tables/platform_routes/indexes/platform_routes_updated_at_idx


SELECT assert_index(CAST('platform_routing_public.platform_routes_updated_at_idx' AS regclass), CAST('platform_routing_public.platform_routes' AS regclass), false);