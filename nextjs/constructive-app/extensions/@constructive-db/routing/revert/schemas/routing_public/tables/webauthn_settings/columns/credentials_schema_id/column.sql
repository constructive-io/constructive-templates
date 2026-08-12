-- Revert: schemas/routing_public/tables/webauthn_settings/columns/credentials_schema_id/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN credentials_schema_id RESTRICT;