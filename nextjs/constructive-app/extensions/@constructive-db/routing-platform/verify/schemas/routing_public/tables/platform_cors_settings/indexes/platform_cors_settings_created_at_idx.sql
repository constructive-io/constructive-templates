-- Verify: schemas/routing_public/tables/platform_cors_settings/indexes/platform_cors_settings_created_at_idx


SELECT assert_index(CAST('routing_public.platform_cors_settings_created_at_idx' AS regclass), CAST('routing_public.platform_cors_settings' AS regclass), false);