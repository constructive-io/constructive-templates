-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/last_used_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/last_used_at/column


COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.last_used_at IS E'Timestamp of the most recent successful sign-in assertion using this credential.';

