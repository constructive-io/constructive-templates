-- Verify: schemas/routing_public/tables/platform_cors_settings/indexes/platform_cors_settings_created_at_idx


SELECT verify_index('routing_public.platform_cors_settings', 'platform_cors_settings_created_at_idx');