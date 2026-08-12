-- Verify: schemas/routing_public/tables/api_settings/indexes/api_settings_database_id_idx


SELECT assert_index(CAST('routing_public.api_settings_database_id_idx' AS regclass), CAST('routing_public.api_settings' AS regclass), false);