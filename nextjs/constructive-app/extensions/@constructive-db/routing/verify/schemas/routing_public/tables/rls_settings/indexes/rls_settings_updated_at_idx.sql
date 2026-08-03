-- Verify: schemas/routing_public/tables/rls_settings/indexes/rls_settings_updated_at_idx


SELECT verify_index('routing_public.rls_settings', 'rls_settings_updated_at_idx');