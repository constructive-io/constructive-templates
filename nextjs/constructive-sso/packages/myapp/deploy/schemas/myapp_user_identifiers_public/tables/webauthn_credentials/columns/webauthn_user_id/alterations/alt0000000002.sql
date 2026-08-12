-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/webauthn_user_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/webauthn_user_id/column


COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.webauthn_user_id IS E'Random per-user handle sent to authenticators as user.id. Privacy-preserving; NOT the internal user UUID.';

