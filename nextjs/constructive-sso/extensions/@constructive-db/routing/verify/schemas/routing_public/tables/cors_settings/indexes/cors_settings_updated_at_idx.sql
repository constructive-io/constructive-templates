-- Verify: schemas/routing_public/tables/cors_settings/indexes/cors_settings_updated_at_idx


SELECT assert_index(CAST('routing_public.cors_settings_updated_at_idx' AS regclass), CAST('routing_public.cors_settings' AS regclass), false);