-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/require_user_verification/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/columns/require_user_verification/column


COMMENT ON COLUMN routing_public.webauthn_settings.require_user_verification IS 'Whether to require user verification (biometric/PIN) during auth';