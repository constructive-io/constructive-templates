-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/credential_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/credential_id/column


COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.credential_id IS E'Base64url-encoded credential ID returned by the authenticator. Globally unique per WebAuthn spec.';

