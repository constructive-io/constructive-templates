-- Revert: schemas/routing_public/tables/webauthn_settings/columns/require_user_verification/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN require_user_verification RESTRICT;