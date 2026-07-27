-- Revert schemas/services_private/triggers/domain_enqueue_issue_cert

BEGIN;

DROP TRIGGER IF EXISTS _000011_domain_enqueue_issue_cert ON services_public.managed_domains;
DROP FUNCTION IF EXISTS services_private.tg_domain_enqueue_issue_cert();

COMMIT;
