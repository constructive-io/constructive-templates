-- Deploy: schemas/myapp_auth_private/tables/session_credentials/columns/principal_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/session_credentials/columns/principal_id/column


COMMENT ON COLUMN myapp_auth_private.session_credentials.principal_id IS E'References the principal (service account) this credential acts on behalf of; NULL for human sessions';

