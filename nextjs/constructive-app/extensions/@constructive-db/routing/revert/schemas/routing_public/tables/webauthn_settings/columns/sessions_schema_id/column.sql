-- Revert: schemas/routing_public/tables/webauthn_settings/columns/sessions_schema_id/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN sessions_schema_id RESTRICT;