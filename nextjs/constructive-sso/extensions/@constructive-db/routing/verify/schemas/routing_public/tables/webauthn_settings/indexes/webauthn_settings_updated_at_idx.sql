-- Verify: schemas/routing_public/tables/webauthn_settings/indexes/webauthn_settings_updated_at_idx


SELECT verify_index('routing_public.webauthn_settings', 'webauthn_settings_updated_at_idx');