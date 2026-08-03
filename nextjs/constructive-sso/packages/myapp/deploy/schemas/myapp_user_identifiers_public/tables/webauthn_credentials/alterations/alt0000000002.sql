-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table


COMMENT ON TABLE myapp_user_identifiers_public.webauthn_credentials IS E'WebAuthn/passkey credentials owned by users. One row per registered authenticator (security key, device biometric, synced passkey). Schema mirrors SimpleWebAuthn''s canonical Passkey object.';

