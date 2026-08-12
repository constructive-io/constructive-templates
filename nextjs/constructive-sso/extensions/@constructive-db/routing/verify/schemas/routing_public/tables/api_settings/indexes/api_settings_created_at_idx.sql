-- Verify: schemas/routing_public/tables/api_settings/indexes/api_settings_created_at_idx


SELECT verify_index('routing_public.api_settings', 'api_settings_created_at_idx');