-- Deploy schemas/services_private/triggers/domain_enqueue_issue_cert to pg

-- requires: schemas/services_private/schema
-- requires: schemas/services_public/tables/managed_domains/table
-- requires: pgpm-database-jobs:schemas/app_jobs/procedures/add_job

BEGIN;

-- Self-driving loop, hop 2 of 3: verified -> invoke domain:issue_cert.
-- domain_verify mirrors verification_status='verified' onto managed_domains on a
-- successful challenge match; this enqueues the domain:issue_cert provisioner,
-- which creates the cert-manager ClusterIssuer + Certificate and moves
-- cert_status to issuing. The WHEN guard fires only on the pending/checking ->
-- verified edge so a repeat verify or an unrelated column update never
-- re-issues.
CREATE FUNCTION services_private.tg_domain_enqueue_issue_cert()
RETURNS TRIGGER AS $$
BEGIN
  PERFORM app_jobs.add_job(
    identifier := 'domain:issue_cert',
    payload := json_build_object(
      'id', NEW.id::text,
      'scope', 'platform'
    ),
    max_attempts := 12
  );
  RETURN NEW;
END;
$$
LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _000011_domain_enqueue_issue_cert
AFTER UPDATE ON services_public.managed_domains
FOR EACH ROW
WHEN (NEW.verification_status = 'verified'
      AND NEW.verification_status IS DISTINCT FROM OLD.verification_status)
EXECUTE FUNCTION services_private.tg_domain_enqueue_issue_cert();

COMMIT;
