-- Verify schemas/services_private/procedures/domain_check_cert

BEGIN;

SELECT has_function_privilege(
  'services_private.domain_check_cert(uuid, boolean, text, uuid)',
  'execute'
);

ROLLBACK;
