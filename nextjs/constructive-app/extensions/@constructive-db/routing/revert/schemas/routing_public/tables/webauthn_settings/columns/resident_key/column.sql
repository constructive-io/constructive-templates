-- Revert: schemas/routing_public/tables/webauthn_settings/columns/resident_key/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN resident_key RESTRICT;