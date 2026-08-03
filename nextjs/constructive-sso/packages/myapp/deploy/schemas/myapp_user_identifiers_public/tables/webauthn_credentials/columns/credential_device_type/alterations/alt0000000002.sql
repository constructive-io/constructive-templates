-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/credential_device_type/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/credential_device_type/column


COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.credential_device_type IS E'Either ''singleDevice'' (hardware-bound) or ''multiDevice'' (synced passkey). Enforced by CHECK constraint below.';

