-- Verify: schemas/platform_routing_public/tables/platform_routes/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('platform_routing_public.platform_routes' AS regclass), 'authenticated', 'INSERT', NULL, true);