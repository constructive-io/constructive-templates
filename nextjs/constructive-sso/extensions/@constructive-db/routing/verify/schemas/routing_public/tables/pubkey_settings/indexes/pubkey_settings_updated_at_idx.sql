-- Verify: schemas/routing_public/tables/pubkey_settings/indexes/pubkey_settings_updated_at_idx


SELECT assert_index(CAST('routing_public.pubkey_settings_updated_at_idx' AS regclass), CAST('routing_public.pubkey_settings' AS regclass), false);