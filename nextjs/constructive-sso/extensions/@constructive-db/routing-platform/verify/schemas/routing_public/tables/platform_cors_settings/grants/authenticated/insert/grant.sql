-- Verify: schemas/routing_public/tables/platform_cors_settings/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.platform_cors_settings' AS regclass), 'authenticated', 'INSERT', NULL, true);