-- Verify: schemas/platform_routing_public/tables/platform_route_bindings/table


SELECT assert_table(CAST('platform_routing_public.platform_route_bindings' AS regclass), false, NULL);