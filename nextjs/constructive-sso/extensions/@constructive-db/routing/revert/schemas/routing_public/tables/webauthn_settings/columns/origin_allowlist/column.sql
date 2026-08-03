-- Revert: schemas/routing_public/tables/webauthn_settings/columns/origin_allowlist/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN origin_allowlist RESTRICT;