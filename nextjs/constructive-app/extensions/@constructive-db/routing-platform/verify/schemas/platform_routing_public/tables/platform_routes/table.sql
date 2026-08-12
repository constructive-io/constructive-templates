-- Verify: schemas/platform_routing_public/tables/platform_routes/table


SELECT assert_table(CAST('platform_routing_public.platform_routes' AS regclass), false, NULL);