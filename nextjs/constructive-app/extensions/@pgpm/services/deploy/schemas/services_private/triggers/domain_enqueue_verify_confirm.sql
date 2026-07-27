-- Deploy schemas/services_private/triggers/domain_enqueue_verify_confirm to pg

-- requires: schemas/services_private/schema
-- requires: schemas/services_public/tables/domain_verifications/table
-- requires: pgpm-database-jobs:schemas/app_jobs/procedures/add_job

BEGIN;

-- Self-driving loop, hop 1 of 3: challenge issued -> schedule domain_verification confirm.
-- domain_issue_challenge INSERTs a fresh row with status='pending'; this enqueues
-- the generic infra:confirm reconcile job for the domain_verification target,
-- which resolves DNS/HTTP and feeds observed values back into domain_verify. The
-- job rides the shared infra_confirm queue with app_jobs retry/backoff (throw =
-- reschedule, max_attempts = terminal); the initial run_at delay lets the user's
-- DNS/HTTP record propagate before the first poll.
CREATE FUNCTION services_private.tg_domain_enqueue_verify_confirm()
RETURNS TRIGGER AS $$
BEGIN
  PERFORM app_jobs.add_job(
    identifier := 'infra:confirm',
    payload := json_build_object(
      'kind', 'domain_verification',
      'id', NEW.managed_domain_id::text,
      'scope', 'platform'
    ),
    queue_name := 'infra_confirm',
    run_at := now() + interval '30 seconds',
    max_attempts := 12
  );
  RETURN NEW;
END;
$$
LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _000010_domain_enqueue_verify_confirm
AFTER INSERT ON services_public.domain_verifications
FOR EACH ROW
WHEN (NEW.status = 'pending')
EXECUTE FUNCTION services_private.tg_domain_enqueue_verify_confirm();

COMMIT;
