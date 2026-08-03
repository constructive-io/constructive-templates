-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/origin_allowlist/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/columns/origin_allowlist/column


COMMENT ON COLUMN routing_public.webauthn_settings.origin_allowlist IS 'Allowed origins for WebAuthn registration and authentication';