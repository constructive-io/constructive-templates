-- Revert: schemas/routing_public/tables/webauthn_settings/columns/schema_id/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN schema_id RESTRICT;