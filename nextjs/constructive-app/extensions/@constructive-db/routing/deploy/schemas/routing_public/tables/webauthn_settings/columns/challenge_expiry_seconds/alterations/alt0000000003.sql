-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/challenge_expiry_seconds/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/columns/challenge_expiry_seconds/column


COMMENT ON COLUMN routing_public.webauthn_settings.challenge_expiry_seconds IS 'Challenge TTL in seconds (default 300 = 5 minutes)';