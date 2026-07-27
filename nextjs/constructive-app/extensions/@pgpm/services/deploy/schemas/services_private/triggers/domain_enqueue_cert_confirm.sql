-- Deploy schemas/services_private/triggers/domain_enqueue_cert_confirm to pg

-- requires: schemas/services_private/schema
-- requires: schemas/services_public/tables/managed_domains/table
-- requires: pgpm-database-jobs:schemas/app_jobs/procedures/add_job

BEGIN;

-- Self-driving loop, hop 3 of 3: issuing -> schedule domain_cert confirm.
-- domain_issue_cert sets cert_status='issuing' (called by the domain:issue_cert
-- provisioner right before it creates the Certificate); this enqueues the
-- infra:confirm reconcile job for the domain_cert target, which reads the
-- cert-manager Certificate Ready condition and feeds it into domain_check_cert.
-- Keeping this on the cert_status edge (rather than enqueuing from the worker)
-- keeps all three hops in one uniform, SQL-driven place. The WHEN guard fires
-- only on the transition into issuing.
CREATE FUNCTION services_private.tg_domain_enqueue_cert_confirm()
RETURNS TRIGGER AS $$
BEGIN
  PERFORM app_jobs.add_job(
    identifier := 'infra:confirm',
    payload := json_build_object(
      'kind', 'domain_cert',
      'id', NEW.id::text,
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

CREATE TRIGGER _000012_domain_enqueue_cert_confirm
AFTER UPDATE ON services_public.managed_domains
FOR EACH ROW
WHEN (NEW.cert_status = 'issuing'
      AND NEW.cert_status IS DISTINCT FROM OLD.cert_status)
EXECUTE FUNCTION services_private.tg_domain_enqueue_cert_confirm();

COMMIT;
