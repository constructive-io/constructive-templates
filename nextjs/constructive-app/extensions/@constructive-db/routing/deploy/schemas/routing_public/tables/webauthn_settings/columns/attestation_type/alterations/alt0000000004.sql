-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/attestation_type/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/table
-- requires: schemas/routing_public/tables/webauthn_settings/columns/attestation_type/column


ALTER TABLE routing_public.webauthn_settings 
  ADD CONSTRAINT webauthn_settings_attestation_type_chk 
    CHECK (attestation_type IN ('none', 'indirect', 'direct', 'enterprise'));