-- Revert schemas/services_private/triggers/domain_enqueue_cert_confirm

BEGIN;

DROP TRIGGER IF EXISTS _000012_domain_enqueue_cert_confirm ON services_public.managed_domains;
DROP FUNCTION IF EXISTS services_private.tg_domain_enqueue_cert_confirm();

COMMIT;
