-- Revert: schemas/routing_public/tables/webauthn_settings/columns/rp_id/alterations/alt0000000001


ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN rp_id DROP NOT NULL;