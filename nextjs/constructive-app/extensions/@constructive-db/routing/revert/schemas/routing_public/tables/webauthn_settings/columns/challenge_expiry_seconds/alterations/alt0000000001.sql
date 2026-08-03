-- Revert: schemas/routing_public/tables/webauthn_settings/columns/challenge_expiry_seconds/alterations/alt0000000001


ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN challenge_expiry_seconds DROP NOT NULL;