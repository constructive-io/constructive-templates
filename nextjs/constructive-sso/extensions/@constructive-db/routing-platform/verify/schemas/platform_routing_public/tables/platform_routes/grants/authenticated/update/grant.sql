-- Verify: schemas/platform_routing_public/tables/platform_routes/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('platform_routing_public.platform_routes' AS regclass), 'authenticated', 'UPDATE', NULL, true);