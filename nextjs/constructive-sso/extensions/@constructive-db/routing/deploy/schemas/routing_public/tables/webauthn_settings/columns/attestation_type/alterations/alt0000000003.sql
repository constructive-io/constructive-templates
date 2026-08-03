-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/attestation_type/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/columns/attestation_type/column


COMMENT ON COLUMN routing_public.webauthn_settings.attestation_type IS 'Attestation conveyance preference (none, indirect, direct, enterprise)';