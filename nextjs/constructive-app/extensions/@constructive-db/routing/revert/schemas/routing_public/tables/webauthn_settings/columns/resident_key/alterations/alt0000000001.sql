-- Revert: schemas/routing_public/tables/webauthn_settings/columns/resident_key/alterations/alt0000000001


ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN resident_key DROP NOT NULL;