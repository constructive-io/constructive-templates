-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/rp_name/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/columns/rp_name/column


COMMENT ON COLUMN routing_public.webauthn_settings.rp_name IS 'WebAuthn Relying Party display name';