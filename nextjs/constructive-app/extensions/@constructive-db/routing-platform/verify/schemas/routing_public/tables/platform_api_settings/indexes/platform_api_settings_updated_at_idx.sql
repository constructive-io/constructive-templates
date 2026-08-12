-- Verify: schemas/routing_public/tables/platform_api_settings/indexes/platform_api_settings_updated_at_idx


SELECT assert_index(CAST('routing_public.platform_api_settings_updated_at_idx' AS regclass), CAST('routing_public.platform_api_settings' AS regclass), false);