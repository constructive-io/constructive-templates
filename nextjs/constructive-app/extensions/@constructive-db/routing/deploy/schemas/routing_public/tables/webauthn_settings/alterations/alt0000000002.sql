-- Deploy: schemas/routing_public/tables/webauthn_settings/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/table


COMMENT ON TABLE routing_public.webauthn_settings IS 'WebAuthn/passkey runtime configuration; relying party options and typed references to the credential/session storage';