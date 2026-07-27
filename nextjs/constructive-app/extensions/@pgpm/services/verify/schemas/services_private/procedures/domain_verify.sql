-- Verify schemas/services_private/procedures/domain_verify

BEGIN;

SELECT has_function_privilege(
  'services_private.domain_verify(uuid, text[], text, integer, uuid)',
  'execute'
);

ROLLBACK;
