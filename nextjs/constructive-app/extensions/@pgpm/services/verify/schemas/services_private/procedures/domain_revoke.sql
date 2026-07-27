-- Verify schemas/services_private/procedures/domain_revoke

BEGIN;

SELECT has_function_privilege(
  'services_private.domain_revoke(uuid, uuid)',
  'execute'
);

ROLLBACK;
