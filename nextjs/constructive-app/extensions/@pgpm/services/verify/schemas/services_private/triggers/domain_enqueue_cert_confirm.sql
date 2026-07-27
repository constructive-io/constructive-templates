-- Verify schemas/services_private/triggers/domain_enqueue_cert_confirm

BEGIN;

SELECT has_function_privilege(
  'services_private.tg_domain_enqueue_cert_confirm()',
  'execute'
);

ROLLBACK;
