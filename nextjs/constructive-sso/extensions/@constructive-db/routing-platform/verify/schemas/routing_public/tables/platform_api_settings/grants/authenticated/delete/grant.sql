-- Verify: schemas/routing_public/tables/platform_api_settings/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.platform_api_settings' AS regclass), 'authenticated', 'DELETE', NULL, true);