-- Verify: schemas/platform_routing_public/tables/platform_routes/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('platform_routing_public.platform_routes' AS regclass), 'authenticated', 'SELECT', NULL, true);