-- Revert schemas/services_private/procedures/domain_verify

BEGIN;

DROP FUNCTION IF EXISTS services_private.domain_verify(uuid, text[], text, integer, uuid);

COMMIT;
