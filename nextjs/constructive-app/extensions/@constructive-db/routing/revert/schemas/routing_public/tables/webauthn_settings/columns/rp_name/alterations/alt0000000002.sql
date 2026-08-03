-- Revert: schemas/routing_public/tables/webauthn_settings/columns/rp_name/alterations/alt0000000002


ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN rp_name DROP DEFAULT;