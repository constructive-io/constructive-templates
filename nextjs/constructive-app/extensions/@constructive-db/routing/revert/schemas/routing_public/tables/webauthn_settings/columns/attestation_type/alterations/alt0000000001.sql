-- Revert: schemas/routing_public/tables/webauthn_settings/columns/attestation_type/alterations/alt0000000001


ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN attestation_type DROP NOT NULL;