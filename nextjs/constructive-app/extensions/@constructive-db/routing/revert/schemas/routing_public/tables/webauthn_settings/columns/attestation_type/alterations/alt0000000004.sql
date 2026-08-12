-- Revert: schemas/routing_public/tables/webauthn_settings/columns/attestation_type/alterations/alt0000000004


ALTER TABLE routing_public.webauthn_settings 
  DROP CONSTRAINT webauthn_settings_attestation_type_chk RESTRICT;