-- Deploy schemas/services_private/procedures/domain_revoke to pg

-- requires: schemas/services_private/schema
-- requires: schemas/services_public/tables/managed_domains/table
-- requires: schemas/services_public/tables/domain_verifications/table
-- requires: schemas/services_public/tables/domain_events/table
-- requires: schemas/services_private/procedures/domain_verify
-- requires: metaschema-schema:schemas/metaschema_public/tables/database/table

BEGIN;

-- domain:revoke — lifecycle-tail STUB.
--
-- Tears down the cert side of a managed_domain: resets cert_status to 'none',
-- drops the recorded cert spec from annotations, and emits a cert_revoked event.
-- verification_status is left untouched — revoking a cert does not un-verify
-- domain ownership.
--
-- TODO(revoke): once ClusterIssuer/Certificate are managed resource kinds, also
-- delete the cert-manager Certificate + its TLS secret (and, for compromised
-- keys, submit an ACME revocation) rather than only clearing DB state.
CREATE FUNCTION services_private.domain_revoke(
    managed_domain_id uuid,
    actor_id uuid DEFAULT NULL
) RETURNS services_public.managed_domains AS $$
DECLARE
    md services_public.managed_domains;
    entity_owner_id uuid;
BEGIN
    SELECT md_row.* INTO md
      FROM services_public.managed_domains AS md_row
     WHERE md_row.id = domain_revoke.managed_domain_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'DOMAIN_REVOKE_UNKNOWN_DOMAIN: no managed_domain with id %', domain_revoke.managed_domain_id
            USING ERRCODE = 'foreign_key_violation';
    END IF;

    SELECT db.owner_id INTO entity_owner_id
      FROM metaschema_public.database AS db
     WHERE db.id = md.database_id;

    UPDATE services_public.managed_domains
       SET cert_status = 'none',
           annotations = annotations - 'cert' - 'cert_error' - 'cert_ready_at'
     WHERE id = domain_revoke.managed_domain_id
    RETURNING * INTO md;

    INSERT INTO services_public.domain_events
        (owner_id, managed_domain_id, domain_verification_id, event_type, actor_id, message, metadata)
    VALUES
        (entity_owner_id, domain_revoke.managed_domain_id, NULL, 'cert_revoked', domain_revoke.actor_id,
         'Revoked certificate for ' || md.domain::text,
         '{}'::jsonb);

    RETURN md;
END;
$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

COMMENT ON FUNCTION services_private.domain_revoke(uuid, uuid) IS 'domain:revoke — STUB: resets cert_status to none, clears the recorded cert spec, and emits cert_revoked (leaves verification_status intact). Deleting the cert-manager Certificate/secret and ACME revocation are a TODO pending managed cert resource kinds.';

GRANT EXECUTE ON FUNCTION services_private.domain_revoke(uuid, uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION services_private.domain_revoke(uuid, uuid) TO administrator;

COMMIT;
