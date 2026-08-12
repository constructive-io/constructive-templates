-- Verify: schemas/platform_routing_public/tables/platform_route_bindings/indexes/platform_route_bindings_domain_id_is_active_idx


SELECT assert_index(CAST('platform_routing_public.platform_route_bindings_domain_id_is_active_idx' AS regclass), CAST('platform_routing_public.platform_route_bindings' AS regclass), false);