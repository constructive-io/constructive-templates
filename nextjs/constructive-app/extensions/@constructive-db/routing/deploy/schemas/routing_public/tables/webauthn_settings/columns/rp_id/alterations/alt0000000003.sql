-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/rp_id/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/columns/rp_id/column


COMMENT ON COLUMN routing_public.webauthn_settings.rp_id IS 'WebAuthn Relying Party ID (typically the domain name)';