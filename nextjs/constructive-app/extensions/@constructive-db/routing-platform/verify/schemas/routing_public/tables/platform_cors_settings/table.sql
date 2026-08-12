-- Verify: schemas/routing_public/tables/platform_cors_settings/table


SELECT assert_table(CAST('routing_public.platform_cors_settings' AS regclass), false, NULL);