-- Verify: schemas/routing_public/tables/platform_cors_settings/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.platform_cors_settings' AS regclass), 'authenticated', 'DELETE', NULL, true);