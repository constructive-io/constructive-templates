-- Verify: schemas/routing_public/tables/platform_api_settings/table


SELECT assert_table(CAST('routing_public.platform_api_settings' AS regclass), false, NULL);