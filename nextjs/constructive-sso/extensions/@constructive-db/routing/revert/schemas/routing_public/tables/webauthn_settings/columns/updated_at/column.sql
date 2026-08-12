-- Revert: schemas/routing_public/tables/webauthn_settings/columns/updated_at/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN updated_at RESTRICT;