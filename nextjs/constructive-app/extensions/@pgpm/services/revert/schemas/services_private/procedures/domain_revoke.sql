-- Revert schemas/services_private/procedures/domain_revoke

BEGIN;

DROP FUNCTION IF EXISTS services_private.domain_revoke(uuid, uuid);

COMMIT;
