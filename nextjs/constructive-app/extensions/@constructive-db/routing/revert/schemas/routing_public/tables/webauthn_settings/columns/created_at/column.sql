-- Revert: schemas/routing_public/tables/webauthn_settings/columns/created_at/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN created_at RESTRICT;