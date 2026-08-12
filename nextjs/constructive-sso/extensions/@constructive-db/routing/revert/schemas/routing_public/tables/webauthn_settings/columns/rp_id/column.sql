-- Revert: schemas/routing_public/tables/webauthn_settings/columns/rp_id/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN rp_id RESTRICT;