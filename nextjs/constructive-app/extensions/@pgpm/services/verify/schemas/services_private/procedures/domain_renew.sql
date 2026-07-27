-- Verify schemas/services_private/procedures/domain_renew

BEGIN;

SELECT has_function_privilege(
  'services_private.domain_renew(uuid, uuid)',
  'execute'
);

ROLLBACK;
