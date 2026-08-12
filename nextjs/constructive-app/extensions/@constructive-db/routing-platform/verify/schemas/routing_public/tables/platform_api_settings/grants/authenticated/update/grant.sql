-- Verify: schemas/routing_public/tables/platform_api_settings/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.platform_api_settings' AS regclass), 'authenticated', 'UPDATE', NULL, true);