-- Revert schemas/services_private/triggers/domain_enqueue_verify_confirm

BEGIN;

DROP TRIGGER IF EXISTS _000010_domain_enqueue_verify_confirm ON services_public.domain_verifications;
DROP FUNCTION IF EXISTS services_private.tg_domain_enqueue_verify_confirm();

COMMIT;
