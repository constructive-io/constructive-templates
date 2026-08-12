-- Verify: schemas/platform_routing_public/tables/platform_routes/indexes/platform_routes_domain_id_path_method_is_active_idx


SELECT assert_index(CAST('platform_routing_public.platform_routes_domain_id_path_method_is_active_idx' AS regclass), CAST('platform_routing_public.platform_routes' AS regclass), false);