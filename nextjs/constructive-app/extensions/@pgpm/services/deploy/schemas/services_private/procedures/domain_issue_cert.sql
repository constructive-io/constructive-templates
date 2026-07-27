-- Deploy schemas/services_private/procedures/domain_issue_cert to pg

-- requires: schemas/services_private/schema
-- requires: schemas/services_public/tables/managed_domains/table
-- requires: schemas/services_public/tables/domain_verifications/table
-- requires: schemas/services_public/tables/domain_events/table
-- requires: schemas/services_private/procedures/domain_verify
-- requires: metaschema-schema:schemas/metaschema_public/tables/database/table

BEGIN;

-- domain:issue_cert — the issue step of the verify->DNS->issue loop, gated on a
-- verified domain.
--
-- Records the desired cert-manager Certificate for a managed_domain and moves
-- cert_status to 'issuing'. This is a pure state machine: it does NOT talk to
-- Kubernetes. It stamps the resolved Certificate spec (issuer ClusterIssuer,
-- dns_names, secretName) into managed_domains.annotations.cert and emits a
-- cert_issuing event carrying the same spec; the actual cert-manager
-- Certificate object is created downstream by the resource reconciler that
-- reuses functions/knative/src/handlers/kinds/certificate.ts.
-- It becomes a graph node LATER; for now a job trigger / the runtime='sql'
-- worker dispatch (registered under the domain:issue_cert task identifier)
-- invokes it and a following node applies the spec to the cluster.
--
-- issuer_env selects the ClusterIssuer (staging vs production) so the caller can
-- dry-run against Let's Encrypt staging before burning prod rate limits.
--
-- The referenced ClusterIssuer (letsencrypt-staging / letsencrypt-prod) is a
-- DB-managed platform `ClusterIssuer` resource (a ClusterIssuer kind handler
-- alongside the Certificate kind in functions/knative/src/handlers/kinds),
-- seeded at platform provisioning and reconciled by resource:provision. We only
-- reference it by name here (issuerRef.kind = 'ClusterIssuer'); its own resource
-- row is what creates/reconciles the cluster object.
CREATE FUNCTION services_private.domain_issue_cert(
    managed_domain_id uuid,
    issuer_env text DEFAULT 'staging',
    secret_name text DEFAULT NULL,
    actor_id uuid DEFAULT NULL
) RETURNS services_public.managed_domains AS $$
DECLARE
    md services_public.managed_domains;
    entity_owner_id uuid;
    issuer_name text;
    dns_names text[];
    resolved_secret_name text;
    cert_spec jsonb;
BEGIN
    IF domain_issue_cert.issuer_env NOT IN ('staging', 'production') THEN
        RAISE EXCEPTION 'DOMAIN_ISSUE_CERT_BAD_ISSUER: unsupported issuer_env % (expected staging|production)', domain_issue_cert.issuer_env
            USING ERRCODE = 'check_violation';
    END IF;

    SELECT md_row.* INTO md
      FROM services_public.managed_domains AS md_row
     WHERE md_row.id = domain_issue_cert.managed_domain_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'DOMAIN_ISSUE_CERT_UNKNOWN_DOMAIN: no managed_domain with id %', domain_issue_cert.managed_domain_id
            USING ERRCODE = 'foreign_key_violation';
    END IF;

    IF md.verification_status <> 'verified' THEN
        RAISE EXCEPTION 'DOMAIN_ISSUE_CERT_NOT_VERIFIED: managed_domain % is % (must be verified before issuing a cert)', domain_issue_cert.managed_domain_id, md.verification_status
            USING ERRCODE = 'check_violation';
    END IF;

    SELECT db.owner_id INTO entity_owner_id
      FROM metaschema_public.database AS db
     WHERE db.id = md.database_id;

    -- letsencrypt-staging vs letsencrypt-prod are the conventional ClusterIssuer
    -- names; the staging issuer avoids Let's Encrypt production rate limits.
    issuer_name := CASE WHEN domain_issue_cert.issuer_env = 'production'
                        THEN 'letsencrypt-prod'
                        ELSE 'letsencrypt-staging'
                   END;

    -- A wildcard managed_domain covers both the apex and every subdomain.
    IF md.is_wildcard THEN
        dns_names := ARRAY[md.domain::text, '*.' || md.domain::text];
    ELSE
        dns_names := ARRAY[md.domain::text];
    END IF;

    resolved_secret_name := coalesce(domain_issue_cert.secret_name, replace(md.domain::text, '.', '-') || '-tls');

    cert_spec := jsonb_build_object(
        'issuer', issuer_name,
        'issuer_env', domain_issue_cert.issuer_env,
        'dns_names', to_jsonb(dns_names),
        'secret_name', resolved_secret_name
    );

    UPDATE services_public.managed_domains
       SET cert_status = 'issuing',
           annotations = annotations || jsonb_build_object('cert', cert_spec)
     WHERE id = domain_issue_cert.managed_domain_id
    RETURNING * INTO md;

    INSERT INTO services_public.domain_events
        (owner_id, managed_domain_id, domain_verification_id, event_type, actor_id, message, metadata)
    VALUES
        (entity_owner_id, domain_issue_cert.managed_domain_id, NULL, 'cert_issuing', domain_issue_cert.actor_id,
         'Requested ' || domain_issue_cert.issuer_env || ' certificate for ' || md.domain::text,
         cert_spec);

    RETURN md;
END;
$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

COMMENT ON FUNCTION services_private.domain_issue_cert(uuid, text, text, uuid) IS 'domain:issue_cert — verified-only guard: records the desired cert-manager Certificate spec (staging vs production ClusterIssuer, dns_names, secretName) on managed_domains.annotations.cert, sets cert_status=issuing, and emits a cert_issuing event. Actual ClusterIssuer/Certificate creation is delegated downstream to the certificate.ts kind handler.';

GRANT EXECUTE ON FUNCTION services_private.domain_issue_cert(uuid, text, text, uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION services_private.domain_issue_cert(uuid, text, text, uuid) TO administrator;

COMMIT;
