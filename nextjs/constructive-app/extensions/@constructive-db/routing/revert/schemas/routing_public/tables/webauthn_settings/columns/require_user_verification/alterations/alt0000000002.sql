-- Revert: schemas/routing_public/tables/webauthn_settings/columns/require_user_verification/alterations/alt0000000002


ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN require_user_verification DROP DEFAULT;