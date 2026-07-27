-- Verify schemas/services_private/procedures/domain_issue_cert

BEGIN;

SELECT has_function_privilege(
  'services_private.domain_issue_cert(uuid, text, text, uuid)',
  'execute'
);

ROLLBACK;
