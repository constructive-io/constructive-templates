-- Verify schemas/services_private/triggers/domain_enqueue_issue_cert

BEGIN;

SELECT has_function_privilege(
  'services_private.tg_domain_enqueue_issue_cert()',
  'execute'
);

ROLLBACK;
