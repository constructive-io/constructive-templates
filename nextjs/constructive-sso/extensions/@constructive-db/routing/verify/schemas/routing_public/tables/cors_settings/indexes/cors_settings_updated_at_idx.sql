-- Verify: schemas/routing_public/tables/cors_settings/indexes/cors_settings_updated_at_idx


SELECT verify_index('routing_public.cors_settings', 'cors_settings_updated_at_idx');