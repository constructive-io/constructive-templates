-- Revert: schemas/routing_public/tables/webauthn_settings/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN updated_at DROP DEFAULT;