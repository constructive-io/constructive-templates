-- Revert: schemas/routing_public/tables/webauthn_settings/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN id DROP DEFAULT;