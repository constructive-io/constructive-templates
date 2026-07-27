-- Deploy schemas/services_private/procedures/domain_renew to pg

-- requires: schemas/services_private/schema
-- requires: schemas/services_public/tables/managed_domains/table
-- requires: schemas/services_public/tables/domain_verifications/table
-- requires: schemas/services_public/tables/domain_events/table
-- requires: schemas/services_private/procedures/domain_verify
-- requires: metaschema-schema:schemas/metaschema_public/tables/database/table

BEGIN;

-- domain:renew — lifecycle-tail STUB.
--
-- cert-manager auto-renews Certificates well before expiry, so an explicit renew
-- is normally a no-op. This registered function exists so the loop can force a
-- renewal: it moves an active cert back to 'issuing' (which re-drives issue_cert/
-- check_cert reconciliation) and emits a cert_renewed event.
--
-- TODO(renew): wire real renewal semantics once ClusterIssuer/Certificate are
-- managed resource kinds — e.g. annotate the Certificate to trigger cert-manager
-- reissuance and track the renewal window, rather than only flipping cert_status.
CREATE FUNCTION services_private.domain_renew(
    managed_domain_id uuid,
    actor_id uuid DEFAULT NULL
) RETURNS services_public.managed_domains AS $$
DECLARE
    md services_public.managed_domains;
    entity_owner_id uuid;
BEGIN
    SELECT md_row.* INTO md
      FROM services_public.managed_domains AS md_row
     WHERE md_row.id = domain_renew.managed_domain_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'DOMAIN_RENEW_UNKNOWN_DOMAIN: no managed_domain with id %', domain_renew.managed_domain_id
            USING ERRCODE = 'foreign_key_violation';
    END IF;

    IF md.cert_status <> 'active' THEN
        RAISE EXCEPTION 'DOMAIN_RENEW_NOT_ACTIVE: managed_domain % has cert_status % (only an active cert can be renewed)', domain_renew.managed_domain_id, md.cert_status
            USING ERRCODE = 'check_violation';
    END IF;

    SELECT db.owner_id INTO entity_owner_id
      FROM metaschema_public.database AS db
     WHERE db.id = md.database_id;

    UPDATE services_public.managed_domains
       SET cert_status = 'issuing'
     WHERE id = domain_renew.managed_domain_id
    RETURNING * INTO md;

    INSERT INTO services_public.domain_events
        (owner_id, managed_domain_id, domain_verification_id, event_type, actor_id, message, metadata)
    VALUES
        (entity_owner_id, domain_renew.managed_domain_id, NULL, 'cert_renewed', domain_renew.actor_id,
         'Requested renewal of certificate for ' || md.domain::text,
         '{}'::jsonb);

    RETURN md;
END;
$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

COMMENT ON FUNCTION services_private.domain_renew(uuid, uuid) IS 'domain:renew — STUB: forces an active cert back to issuing to re-drive reconciliation and emits cert_renewed. Real cert-manager renewal semantics are a TODO pending ClusterIssuer/Certificate becoming managed resource kinds.';

GRANT EXECUTE ON FUNCTION services_private.domain_renew(uuid, uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION services_private.domain_renew(uuid, uuid) TO administrator;

COMMIT;
