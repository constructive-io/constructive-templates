-- Revert: schemas/routing_public/tables/webauthn_settings/columns/resident_key/alterations/alt0000000004


ALTER TABLE routing_public.webauthn_settings 
  DROP CONSTRAINT webauthn_settings_resident_key_chk RESTRICT;