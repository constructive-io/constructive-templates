-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/public_key/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/public_key/column


COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.public_key IS E'COSE-encoded public key bytes from the authenticator attestation.';

