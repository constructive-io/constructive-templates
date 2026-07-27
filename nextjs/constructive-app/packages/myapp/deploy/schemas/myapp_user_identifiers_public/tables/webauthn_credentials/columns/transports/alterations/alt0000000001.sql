-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/transports/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/transports/column


COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.transports IS E'Authenticator transport hints (e.g. usb, nfc, ble, internal, hybrid). Used to hint browser UI during sign-in.';

