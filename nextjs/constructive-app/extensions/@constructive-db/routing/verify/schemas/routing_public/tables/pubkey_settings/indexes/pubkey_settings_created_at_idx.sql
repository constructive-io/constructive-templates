-- Verify: schemas/routing_public/tables/pubkey_settings/indexes/pubkey_settings_created_at_idx


SELECT verify_index('routing_public.pubkey_settings', 'pubkey_settings_created_at_idx');