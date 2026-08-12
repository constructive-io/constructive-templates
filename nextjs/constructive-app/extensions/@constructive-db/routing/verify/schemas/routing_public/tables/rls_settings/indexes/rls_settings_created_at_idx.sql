-- Verify: schemas/routing_public/tables/rls_settings/indexes/rls_settings_created_at_idx


SELECT assert_index(CAST('routing_public.rls_settings_created_at_idx' AS regclass), CAST('routing_public.rls_settings' AS regclass), false);