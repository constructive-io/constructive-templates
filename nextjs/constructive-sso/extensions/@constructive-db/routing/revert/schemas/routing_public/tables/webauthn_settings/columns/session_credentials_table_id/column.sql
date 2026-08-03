-- Revert: schemas/routing_public/tables/webauthn_settings/columns/session_credentials_table_id/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN session_credentials_table_id RESTRICT;