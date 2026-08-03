-- Verify: schemas/routing_public/tables/platform_api_settings/indexes/platform_api_settings_updated_at_idx


SELECT verify_index('routing_public.platform_api_settings', 'platform_api_settings_updated_at_idx');