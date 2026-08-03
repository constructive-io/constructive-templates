-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/backup_state/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/columns/backup_state/column


COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.backup_state IS E'Current backup state; updated on each successful sign-in assertion.';

