-- Verify: schemas/routing_public/tables/platform_api_settings/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.platform_api_settings' AS regclass), 'authenticated', 'INSERT', NULL, true);