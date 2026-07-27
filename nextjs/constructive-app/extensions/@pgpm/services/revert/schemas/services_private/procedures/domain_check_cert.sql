-- Revert schemas/services_private/procedures/domain_check_cert

BEGIN;

DROP FUNCTION IF EXISTS services_private.domain_check_cert(uuid, boolean, text, uuid);

COMMIT;
