-- Revert: schemas/routing_public/tables/webauthn_settings/columns/id/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN id RESTRICT;