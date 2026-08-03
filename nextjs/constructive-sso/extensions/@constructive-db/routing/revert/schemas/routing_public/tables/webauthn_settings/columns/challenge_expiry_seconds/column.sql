-- Revert: schemas/routing_public/tables/webauthn_settings/columns/challenge_expiry_seconds/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN challenge_expiry_seconds RESTRICT;