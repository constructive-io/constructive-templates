-- Verify: schemas/platform_routing_public/tables/platform_hostname_bindings/table


SELECT assert_table(CAST('platform_routing_public.platform_hostname_bindings' AS regclass), false, NULL);