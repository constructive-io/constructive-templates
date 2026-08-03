-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/backup_eligible/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/backup_eligible/column


COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.backup_eligible IS E'Whether this credential is eligible for backup (syncing) per the authenticator''s flags at registration.';

