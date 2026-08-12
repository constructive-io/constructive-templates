-- Revert: schemas/routing_public/tables/webauthn_settings/columns/attestation_type/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN attestation_type RESTRICT;