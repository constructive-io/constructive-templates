-- Verify: schemas/routing_public/tables/webauthn_settings/indexes/webauthn_settings_created_at_idx


SELECT assert_index(CAST('routing_public.webauthn_settings_created_at_idx' AS regclass), CAST('routing_public.webauthn_settings' AS regclass), false);