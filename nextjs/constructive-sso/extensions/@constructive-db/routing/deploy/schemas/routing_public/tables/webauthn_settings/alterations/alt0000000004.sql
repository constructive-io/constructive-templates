-- Deploy: schemas/routing_public/tables/webauthn_settings/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/table


COMMENT ON TABLE routing_public.webauthn_settings IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
WebAuthn/passkey runtime configuration; relying party options and typed references to the credential/session storage';