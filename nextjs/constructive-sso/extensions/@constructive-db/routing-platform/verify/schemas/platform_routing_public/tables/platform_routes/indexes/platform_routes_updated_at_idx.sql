-- Verify: schemas/platform_routing_public/tables/platform_routes/indexes/platform_routes_updated_at_idx


SELECT verify_index('platform_routing_public.platform_routes', 'platform_routes_updated_at_idx');