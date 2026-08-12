-- Verify: schemas/routing_public/tables/database_settings/indexes/database_settings_created_at_idx


SELECT assert_index(CAST('routing_public.database_settings_created_at_idx' AS regclass), CAST('routing_public.database_settings' AS regclass), false);