-- Verify: schemas/routing_public/tables/database_settings/indexes/database_settings_created_at_idx


SELECT verify_index('routing_public.database_settings', 'database_settings_created_at_idx');