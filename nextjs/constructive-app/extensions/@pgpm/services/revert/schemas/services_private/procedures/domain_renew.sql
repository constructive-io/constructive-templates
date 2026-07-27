-- Revert schemas/services_private/procedures/domain_renew

BEGIN;

DROP FUNCTION IF EXISTS services_private.domain_renew(uuid, uuid);

COMMIT;
