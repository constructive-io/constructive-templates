-- Revert: schemas/routing_public/tables/webauthn_settings/columns/rp_name/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN rp_name RESTRICT;