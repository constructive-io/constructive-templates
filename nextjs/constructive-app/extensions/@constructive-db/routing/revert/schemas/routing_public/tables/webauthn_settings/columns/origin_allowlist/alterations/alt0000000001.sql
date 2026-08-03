-- Revert: schemas/routing_public/tables/webauthn_settings/columns/origin_allowlist/alterations/alt0000000001


ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN origin_allowlist DROP NOT NULL;