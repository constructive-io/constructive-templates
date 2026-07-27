-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/name/column


COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.name IS E'User-provided label for this credential (e.g. "YubiKey 5C", "iPhone 15"). Renamed via rename_passkey.';

