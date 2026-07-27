-- Revert schemas/services_private/procedures/domain_issue_cert

BEGIN;

DROP FUNCTION IF EXISTS services_private.domain_issue_cert(uuid, text, text, uuid);

COMMIT;
