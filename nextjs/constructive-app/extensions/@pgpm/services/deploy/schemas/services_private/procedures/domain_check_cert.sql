-- Deploy schemas/services_private/procedures/domain_check_cert to pg

-- requires: schemas/services_private/schema
-- requires: schemas/services_public/tables/managed_domains/table
-- requires: schemas/services_public/tables/domain_verifications/table
-- requires: schemas/services_public/tables/domain_events/table
-- requires: schemas/services_private/procedures/domain_verify
-- requires: metaschema-schema:schemas/metaschema_public/tables/database/table

BEGIN;

-- domain:check_cert — reconciles the cert-manager Certificate readiness for a
-- managed_domain that is currently issuing.
--
-- Pure state machine: it does NOT poll cert-manager itself. The reconciler that
-- fronts this node observes the Certificate's Ready condition and passes the
-- result in as cert_ready (+ cert_error on failure), mirroring how domain_verify
-- receives observed_values. Transitions on cert_status:
--   * cert_error not null -> 'error'   (cert_error event)
--   * cert_ready is true  -> 'active'  (cert_active event, stamps annotations.cert.ready_at)
--   * otherwise           -> stays 'issuing' (no event)
-- It becomes a graph node LATER; for now a job trigger / the runtime='sql'
-- worker dispatch (registered under the domain:check_cert task identifier)
-- invokes it with the observed readiness.
CREATE FUNCTION services_private.domain_check_cert(
    managed_domain_id uuid,
    cert_ready boolean DEFAULT NULL,
    cert_error text DEFAULT NULL,
    actor_id uuid DEFAULT NULL
) RETURNS services_public.managed_domains AS $$
DECLARE
    md services_public.managed_domains;
    entity_owner_id uuid;
BEGIN
    SELECT md_row.* INTO md
      FROM services_public.managed_domains AS md_row
     WHERE md_row.id = domain_check_cert.managed_domain_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'DOMAIN_CHECK_CERT_UNKNOWN_DOMAIN: no managed_domain with id %', domain_check_cert.managed_domain_id
            USING ERRCODE = 'foreign_key_violation';
    END IF;

    IF md.cert_status NOT IN ('issuing', 'active', 'error') THEN
        RAISE EXCEPTION 'DOMAIN_CHECK_CERT_NOT_ISSUING: managed_domain % has cert_status % (issue a cert first)', domain_check_cert.managed_domain_id, md.cert_status
            USING ERRCODE = 'check_violation';
    END IF;

    SELECT db.owner_id INTO entity_owner_id
      FROM metaschema_public.database AS db
     WHERE db.id = md.database_id;

    IF domain_check_cert.cert_error IS NOT NULL THEN
        UPDATE services_public.managed_domains
           SET cert_status = 'error',
               annotations = annotations || jsonb_build_object('cert_error', domain_check_cert.cert_error)
         WHERE id = domain_check_cert.managed_domain_id
        RETURNING * INTO md;

        INSERT INTO services_public.domain_events
            (owner_id, managed_domain_id, domain_verification_id, event_type, actor_id, message, metadata)
        VALUES
            (entity_owner_id, domain_check_cert.managed_domain_id, NULL, 'cert_error', domain_check_cert.actor_id,
             'Certificate for ' || md.domain::text || ' failed: ' || domain_check_cert.cert_error,
             jsonb_build_object('error', domain_check_cert.cert_error));

        RETURN md;
    END IF;

    IF domain_check_cert.cert_ready IS TRUE THEN
        UPDATE services_public.managed_domains
           SET cert_status = 'active',
               annotations = annotations || jsonb_build_object('cert_ready_at', now())
         WHERE id = domain_check_cert.managed_domain_id
        RETURNING * INTO md;

        INSERT INTO services_public.domain_events
            (owner_id, managed_domain_id, domain_verification_id, event_type, actor_id, message, metadata)
        VALUES
            (entity_owner_id, domain_check_cert.managed_domain_id, NULL, 'cert_active', domain_check_cert.actor_id,
             'Certificate for ' || md.domain::text || ' is active',
             '{}'::jsonb);

        RETURN md;
    END IF;

    -- Not ready yet and no error reported: leave cert_status = 'issuing' so the
    -- reconciler keeps polling under the job's max_attempts / backoff.
    RETURN md;
END;
$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

COMMENT ON FUNCTION services_private.domain_check_cert(uuid, boolean, text, uuid) IS 'domain:check_cert — reconciles observed cert-manager Certificate readiness onto managed_domains.cert_status (active/error) and emits cert_active/cert_error; stays issuing when not yet ready.';

GRANT EXECUTE ON FUNCTION services_private.domain_check_cert(uuid, boolean, text, uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION services_private.domain_check_cert(uuid, boolean, text, uuid) TO administrator;

COMMIT;
