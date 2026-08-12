-- Revert: schemas/routing_public/tables/webauthn_settings/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.webauthn_settings 
  ALTER COLUMN database_id DROP NOT NULL;