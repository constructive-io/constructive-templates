-- Revert: schemas/routing_public/tables/webauthn_settings/columns/database_id/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN database_id RESTRICT;